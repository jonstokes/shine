module Shine
  class Category < ActiveRecord::Base
    include Shine::Concerns::AssetMountable
    
    validates :title,   presence: true
    validates :icon_id, presence: true, format: UUID_REGEXP

    mount_asset :icon

    def posts
      Post.where("'#{id}' = ANY(category_ids)")
    end
  end
end