module SyncIterator
  def sync_each_item(sync_session:)
    request = Content::SyncRequest.new(sync_session.mode)
    response = request.fetch!
    while !response.completed? do
      response.items.each do |item|
        yield item
      end
      response = request.fetch!
    end
    sync_session_id.update(next_sync_url: response.next_sync_url)
  end
end