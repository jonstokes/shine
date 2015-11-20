module Shine
  class Category < ActiveRecord::Base
    include Shine::Concerns::Syncable

    def posts
      Post.where("'#{cid}' = ANY(category_cids)")
    end

    def self.item_to_attributes(item)
      {
        cid:      item.id,
        title:    item[:title],
        icon_cid: extract_object_cid(item[:icon])
      }
    end
  end
end