class Category < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:               id,
        title:             field(:title),
        icon_cid:          extract_cid(field(:icon))
      }
    end
  end

  class ItemMapper < ::ItemMapper
    include Post::Mapper
  end

  include Syncable

  def posts
    Post.where("'#{cid}' = ANY(category_cids)")
  end
end