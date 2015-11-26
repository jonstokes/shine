module Shine
  module Concerns
    module AssetMountable
      extend ActiveSupport::Concern

      included do
        extend ClassMethods
        attr_accessor :asset_user_id
      end

      module ClassMethods
        def mount_asset(attribute_name)
          define_method attribute_name do
            return instance_variable_get("@#{attribute_name}") if instance_variable_get("@#{attribute_name}")
            instance_variable_set(
              "@#{attribute_name}",
              Shine::Asset.find_by(id: self.send("#{attribute_name}_id"))
            )
          end

          define_method "#{attribute_name}_url" do
            self.send(attribute_name).try(:url)
          end

          define_method "#{attribute_name}_url=" do |value|
            # TODO: Needs a way to get user_id in there
            next unless value.present?
            create_asset = CreateAssetFromUploadcareUrl.call(file_url: value, user_id: asset_user_id)
            self.send("#{attribute_name}_id=", create_asset.asset.id) if create_asset.success?
          end
        end
      end
    end
  end
end