class Asset < ActiveRecord::Base
  include Syncable

  validates :file, presence: true

  def self.item_to_attributes(item)
    {
      cid:         item.id,
      file:        item[:file],
      title:       item[:title],
      description: item[:description]
    }
  end
end
