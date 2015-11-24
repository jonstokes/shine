module Shine
  class Category < ActiveRecord::Base

    validates :title,   presence: true
    validates :icon_id, presence: true, format: UUID_REGEXP
    
    def posts
      Post.where("'#{id}' = ANY(category_ids)")
    end

    def icon
      @icon ||= Shine::Asset.find_by(id: icon_id)
    end
  end
end