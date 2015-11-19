module Content
  class SyncResponse
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def body
      @body ||= JSON.parse(@response.body)
    end

    def next_sync_url
      body['nextSyncUrl']
    end

    def next_page_url
      body['nextPageUrl']
    end

    def completed?
      !!next_page_url
    end

    def items
      @items ||= body['items'].map { |i| Content::Item.new(i) }
    end
  end
end