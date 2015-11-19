module Content
  class Item
    attr_accessor :data

    ENTRY_TYPE_CACHE = {
      Figaro.env.post_id => "Post",
      Figaro.env.author_id => "Author",
      Figaro.env.category_id => "Category"
    }

    def initial(data)
      @data = data
    end

    def convert_to_attributes_hash
      klass::ItemMapper.new(self).to_hash
    end

    def klass
      @klass ||= begin
        if type == "Entry"
          ENTRY_TYPE_CACHE[sys['contentType']['id']].constantize
        else
          type.constantize
        end
      end
    end

    def id
      sys['id']
    end

    def field(name)
      fields[name.to_s][Content.locale]
    end

    def created_at
      sys['createdAt']
    end

    def updated_at
      sys['updatedAt']
    end

    private

    def type
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