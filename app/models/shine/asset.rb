module Shine
  class Asset < ActiveRecord::Base
    include Shine::Concerns::Syncable

    validates :file, presence: true

    def url
      "https:#{file['url']}"
    end

    def self.item_to_attributes(item)
      {
        cid:         item.id,
        file:        item[:file],
        title:       item[:title],
        description: item[:description]
      }
    end
  end
end