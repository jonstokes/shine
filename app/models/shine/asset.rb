module Shine
  class Asset < ActiveRecord::Base
    belongs_to :post
    belongs_to :user

    after_destroy :remove_from_uploadcare, :update_content

    validates :file,        presence: true
    validates :user_id,     presence: true, format: UUID_REGEXP
    validates :uploaded_at, presence: true

    after_initialize { self.file ||= {} }

    def url
      "http://www.ucarecdn.com/#{file['id']}/"
    end

    def thumbnail_url
      "#{url}-/preview/100x100/"
    end

    def preview_url
      "#{url}-/preview/300x500/"
    end

    private

    def update_content
      Post.where(featured_image_id: id).update_all(featured_image_id: nil)
      Category.where(icon_id: id).update_all(icon_id: nil)
      User.where(profile_photo_id: id).update_all(profile_photo_id: nil)
    end

    def remove_from_uploadcare
      UPLOADCARE_SETTINGS.api.file(file_id).delete
    rescue Uploadcare::Error::RequestError::NotFound
      true
    end
  end
end