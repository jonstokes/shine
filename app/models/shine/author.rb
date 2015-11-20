module Shine
  class Author < ActiveRecord::Base
    include Shine::Concerns::Syncable

    validates :name, presence: true

    def posts
      Post.where("'#{cid}' = ANY(author_cids)")
    end

    def self.item_to_attributes(item)
      {
        cid:               item.id,
        name:              item[:name],
        website:           item[:website],
        biography:         item[:biography],
        profile_photo_cid: extract_object_cid(item[:profilePhoto])
      }
    end
  end
end