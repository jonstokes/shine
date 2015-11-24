module Shine
  class Asset < ActiveRecord::Base
    belongs_to :post
    belongs_to :user

    validates :file,    presence: true
    validates :user_id, presence: true, format: UUID_REGEXP

    def url
      "https:#{file['url']}"
    end
  end
end