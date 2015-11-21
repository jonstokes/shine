module Shine
  class Post < ActiveRecord::Base
    include Shine::Concerns::Syncable

    # Author & category data is cached with the post for speed
    validates :author_cids, presence: true
    validates :category_cids, presence: true
    validates :title, :slug, :body, :excerpt, presence: true

    def authors
      Shine::Author.where(cid: author_cids)
    end

    def categories
      Shine::Category.where(cid: category_cids)
    end

    def featured_image
      Shine::Asset.find_by(cid: featured_image_cid)
    end

    def self.item_to_attributes(item)
      {
        cid:                item.id,
        title:              item[:title],
        slug:               "#{item[:date].gsub("-","/")}/#{item[:slug]}",
        author_cids:        item[:author].map { |obj| extract_object_cid(obj) },
        body:               Kramdown::Document.new(item[:body]).to_html,
        excerpt:            item[:excerpt],
        category_cids:      item[:category].map { |obj| extract_object_cid(obj) },
        tags:               item[:tags],
        featured_image_cid: extract_object_cid(item[:featuredImage]),
        date:               item[:date],
        comments:           item[:comments]
      }
    end
  end
end