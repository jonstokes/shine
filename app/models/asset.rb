class Asset < ActiveRecord::Base
  module Mapper
    def to_hash
      {
        cid:         cid,
        file:        file_properties,
        title:       field(:title),
        description: field(:description)
      }
    end

    private

    def file_properties
      if field(:file).respond_to?(:properties)
        field(:file).properties
      else
        field(:file)
      end
    end
  end

  class ObjectMapper < ::ObjectMapper
    include Asset::Mapper
  end

  class RequestMapper < ::RequestMapper
    include Asset::Mapper
  end

  include Syncable

  validates :file, presence: true
end
