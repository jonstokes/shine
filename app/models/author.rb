class Author < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:               id,
        name:              field(:name),
        website:           field(:website),
        biography:         field(:biography),
        profile_photo_cid: extract_cid(field(:profilePhoto))
      }
    end
  end

  class ItemMapper < ::ItemMapper
    include Author::Mapper
  end

  include Syncable

  validates :name, presence: true

  def posts
    Post.where("'#{cid}' = ANY(author_cids)")
  end
end