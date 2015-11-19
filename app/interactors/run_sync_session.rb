class RunSyncSession
  include Troupe
  attr_reader :sync_session

  permits(:mode) { "all" }

  def call
    return if SyncSession.sync_in_progress?
    @sync_session = SyncSession.create(status: "started", mode: mode)
    sync_each_item do |item|
      if item.record?
        UpsertContentItem.call(item: item, sync_session_id: sync_session.id)
      else
        DeleteContentItem.call(item: item)
      end
    end
    sync_session.update(status: "success")
  rescue Contentful::Error => e
    sync_session.update(
      status: "failure",
      error: e.message
    )
  end

  def sync_each_item
    request  = Content::SyncRequest.new(
      starting_sync_url: sync_session.starting_sync_url,
      sync_type:         sync_session.mode
    )
    loop do
      response = request.fetch!
      response.items.each do |item|
        yield item
      end
      if response.completed?
        sync_session.update(next_sync_url: response.next_sync_url)
        break
      end
      request  = Content::SyncRequest.new(starting_sync_url: response.next_page_url)
    end
  end
end