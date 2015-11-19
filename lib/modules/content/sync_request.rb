module Content
  class SyncRequest
    attr_reader :next_sync_url

    def initialize(mode='upsert')
      @mode = mode
      @next_sync_url = SyncSession.next_sync_url(mode)
    end

    def fetch!
      SyncResponse.new Content.connection.get(resource)
    end

    private

    def resource
      if initial?
        "/spaces/#{space}/sync?access_token=#{access_token}&initial=true&type=#{type}"
      else
        uri = URI.parse(next_sync_url)
        "#{uri.path}?#{uri.query}&access_token=#{access_token}"
      end
    end

    def initial?
      !next_sync_url
    end

    def type
      if 'delete' == @mode
        'Deletion'
      else
        'all'
      end
    end

    def access_token; Content.configuration.access_token; end
    def space;        Content.configuration.space;        end
  end
end