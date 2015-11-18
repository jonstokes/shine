class Category < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:               cid,
        title:             field(:title),
        icon_cid:          extract_object_cid(field(:icon))
      }
    end
  end

  class ObjectMapper < ::ObjectMapper
    include Category::Mapper
  end

  class RequestMapper < ::RequestMapper
    include Category::Mapper
  end

  include Syncable

  def posts
    Post.where("'#{cid}' = ANY(category_cids)")
  end
end