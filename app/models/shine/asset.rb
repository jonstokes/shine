module Shine
  class Asset < ActiveRecord::Base
    belongs_to :post
    belongs_to :user

    attr_reader :file_url

    validates :file,    presence: true
    validates :user_id, presence: true, format: UUID_REGEXP

    def file_url=(value)
      return unless value.present?
      self.file = { 'url' => value }
    end

    def url
      file['url']
    end
  end
end