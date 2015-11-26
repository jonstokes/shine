module Shine
  class Asset < ActiveRecord::Base
    belongs_to :post
    belongs_to :user

    attr_reader :file_id, :file_name, :file_source, :file_size

    validates :file,    presence: true
    validates :user_id, presence: true, format: UUID_REGEXP

    def set_file_attribute(attribute, value)
      return unless value.present?
      self.file ||= {}
      self.file.merge!(attribute => value)
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
  end
end