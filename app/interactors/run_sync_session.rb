class RunSyncSession
  include Troupe

  permits(:mode) { "all" }

  provides(:sync_session) do
    SyncSession.create(status: "started", mode: mode)
  end

  def call
    return if SyncSession.in_progress?

    sync_each_item(sync_session) do |item|
      if item.record?
        UpsertItem.call(item: item, sync_session_id: sync_session.id)
      else
        DeleteItem.call(item: item)
      end
    end
    sync_session.update(status: "success")
  rescue Contentful::Error => e
    sync_session.update(
      status: "failure",
      error: e.message
    )
  end

  def sync_each_item(sync_session)
    request  = Content::SyncRequest.new(
      starting_sync_url: sync_session.starting_sync_url,
      sync_type:         sync_session.sync_type
    )
    response = request.fetch!

    while !response.completed? do
      response.items.each do |item|
        yield item
      end
      request  = Content::SyncRequest.new(starting_sync_url: response.next_page_url)
      response = request.fetch!
    end
    sync_session_id.update(next_sync_url: response.next_sync_url)
  end
end