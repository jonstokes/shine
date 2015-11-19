class Post < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:                id,
        title:              field(:title),
        slug:               field(:slug),
        author_cids:        extract_cids(field(:author)),
        body:               field(:body),
        category_cids:      extract_cids(field(:category)),
        tags:               field(:tags),
        featured_image_cid: extract_cid(field(:featuredImage)),
        date:               field(:date),
        comments:           field(:comments)
      }
    end
  end

  class ItemMapper < ::ItemMapper
    include Post::Mapper
  end

  include Syncable

  # Author & category data is cached with the post for speed
  validates :author_cids, presence: true
  validates :category_cids, presence: true
  validates :title, :slug, :body, presence: true

  def authors
    Author.where(cid: author_cids)
  end

  def categories
    Category.where(cid: category_cids)
  end

  def featured_image
    Asset.find_by(cid: featured_image_cid)
  end
end