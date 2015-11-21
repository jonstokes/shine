require 'figaro'

module Shine
  class Item
    attr_accessor :data

    ENTRY_TYPE_CACHE = {
      Figaro.env.post_id => "Post",
      Figaro.env.author_id => "Author",
      Figaro.env.category_id => "Category"
    }

    def initialize(data)
      @data = data
    end

    def id
      sys['id']
    end

    def [](name)
      fields[name.to_s].try(:[], Shine.locale)
    end

    def created_at
      sys['createdAt']
    end

    def updated_at
      sys['updatedAt']
    end

    def record?
      %w(Entry Asset).include?(type)
    end

    def deletion?
      %w(DeletedEntry DeletedAsset).include?(type)
    end

    def klass
      @klass ||= begin
        if type == "Entry"
          "Shine::#{ENTRY_TYPE_CACHE[content_type_id]}".constantize
        elsif type == "Asset"
          Shine::Asset
        end
      end
    end

    def content_type_id
      return unless record?
      sys['contentType']['sys']['id']
    end

    def type
      # Types can be: Entry, Asset, DeletedEntry, DeletedAsset
      sys['type']
    end

    def fields
      @data['fields']
    end

    def sys
      @data['sys']
    end
  end
end