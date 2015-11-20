module Shine
  class SyncRequest
    attr_reader :starting_sync_url

    def initialize(sync_type: nil, starting_sync_url: nil)
      @starting_sync_url = starting_sync_url
      @sync_type = sync_type
    end

    def fetch!
      Shine::SyncResponse.new Shine.connection[resource].get
    end

    def sync_type
      # So gross, but API is case sensitive here.
      @sync_type == "deletion" ? "Deletion" : "all"
    end

    private

    def resource
      if initial?
        "/spaces/#{space}/sync?access_token=#{access_token}&initial=true&type=#{sync_type}"
      else
        uri = URI.parse(starting_sync_url)
        "#{uri.path}?#{uri.query}&access_token=#{access_token}"
      end
    end

    def initial?
      !starting_sync_url
    end

    def access_token; Shine.configuration.access_token; end
    def space;        Shine.configuration.space;        end
  end
end