module Shine
  class Post < ActiveRecord::Base
    include Shine::Concerns::AssetMountable

    has_many :assets

    validates :user_ids,       presence: true
    validates :category_ids,   presence: true
    validates :title, :slug,   presence: true
    validates :body, :excerpt, presence: true
    validates :comments,       presence: true
    validates :status,         presence: true, inclusion: { in: %w(draft pending published) }

    mount_asset :featured_image

    def users
      Shine::User.where(id: user_ids)
    end

    def categories
      Shine::Category.where(id: category_ids)
    end
  end
end