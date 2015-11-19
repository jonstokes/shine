class Asset < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:         id,
        file:        field(:file)['properties'],
        title:       field(:title),
        description: field(:description)
      }
    end
  end

  class ItemMapper < ::ItemMapper
    include Asset::Mapper
  end

  include Syncable

  validates :file, presence: true
end
