class Post < ActiveRecord::Base
  validates :contentful_id, presence: true

  def self.create_or_update_from_entry(entry)
    if post = Post.find_by(contentful_id: entry.id)
      update_from_entry(post: post, entry: entry)
    else
      create_from_entry(entry)
    end
  end

  def self.create_from_entry(entry)
    Post.create(
      title: entry.fields[:title]
      author_ids: entry.fields[:author].map(&:id)
    )
  end
end