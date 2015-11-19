class Post < ActiveRecord::Base
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

  def self.item_to_attributes(item)
    {
      cid:                item.id,
      title:              item[:title],
      slug:               item[:slug],
      author_cids:        item[:author].map { |h| h['sys']['id'] },
      body:               item[:body],
      category_cids:      item[:category].map { |h| h['sys']['id'] },,
      tags:               item[:tags],
      featured_image_cid: item[:featuredImage]['sys']['id'],
      date:               item[:date],
      comments:           item[:comments]
    }
  end
end