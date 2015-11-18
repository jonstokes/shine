class Author < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:               cid,
        name:              field(:name),
        website:           field(:website),
        biography:         field(:biography),
        profile_photo_cid: extract_object_cid(field(:profilePhoto))
      }
    end
  end

  class ObjectMapper < ::ObjectMapper
    include Author::Mapper
  end

  class RequestMapper < ::RequestMapper
    include Author::Mapper
  end

  include Syncable

  validates :name, presence: true

  def posts
    Post.where("'#{cid}' = ANY(author_cids)")
  end
end