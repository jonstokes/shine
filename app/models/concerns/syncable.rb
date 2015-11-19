module Syncable
  extend ActiveSupport::Concern

  included do
    belongs_to :sync_session

    validates :cid, presence: true
    validates :sync_session_id, format: { with: UUID_REGEXP }, allow_blank: true
  end

  def self.convert_item_to_attributes_hash(item)
    item.klass::Mapper.new(item)
  end
end