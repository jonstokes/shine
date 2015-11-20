module Shine
  module Concerns
    module Syncable
      extend ActiveSupport::Concern

      included do
        extend ClassMethods

        belongs_to :sync_session

        validates :cid, presence: true
        validates :sync_session_id, format: { with: Shine::UUID_REGEXP }, allow_blank: true
      end

      module ClassMethods
        def extract_object_cid(obj)
          return unless obj && obj['sys']
          obj['sys']['id']
        end
      end
    end
  end
end