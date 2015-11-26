module Shine
  class Asset < ActiveRecord::Base
    belongs_to :post
    belongs_to :user

    attr_reader :file_url, :file_id, :file_name, :file_source, :file_size

    after_destroy :remove_from_uploadcare, :update_content

    validates :file,    presence: true
    validates :user_id, presence: true, format: UUID_REGEXP

    after_initialize { self.file ||= {} }

    %w(file_id file_name file_source file_size).each do |key|
      attribute = key.split("_").last
      define_method key do
        file[attribute]
      end
    end

    def file_url=(value)
      return unless value.present?
      value = value.split("/")[3]
      set_file_attribute('id', value)
    end

    def file_id=(value)
      set_file_attribute('id', value)
    end

    def file_name=(value)
      set_file_attribute('name', value)
    end

    def file_source=(value)
      set_file_attribute('source', value)
    end

    def file_size=(value)
      set_file_attribute('size', value)
    end

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

    def set_file_attribute(attribute, value)
      return unless value.present?
      self.file ||= {}
      self.file.merge!(attribute => value)
    end
  end
end