module Shine
  class Post < ActiveRecord::Base

    has_many :assets

    validates :user_ids,       presence: true
    validates :category_ids,   presence: true
    validates :title, :slug,   presence: true
    validates :body, :excerpt, presence: true
    validates :comments,       presence: true
    validates :status,         presence: true, inclusion: { in: %w(draft pending published) }

    def users
      Shine::User.where(id: user_ids)
    end

    def categories
      Shine::Category.where(id: category_ids)
    end

    def featured_image
      Shine::Asset.find_by(id: featured_image_id)
    end
  end
end