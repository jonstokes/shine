class MakeUpsertChanges
  include Troupe
  include SyncIterator

  provides(:sync_session) do
    SyncSession.create(status: "started", mode: "upsert")
  end

  def call
    sync_each_item(sync_session: sync_session) do |item|
      attrs = item.convert_to_attributes_hash.merge(sync_session_id: sync_session.id)
      if record = item.klass.find_by(cid: attrs[:cid])
        record.update(attrs)
      else
        item.klass.create(attrs)
      end
    end
    sync_session.update(status: "success")
  rescue Contentful::Error => e
    sync_session.update(
      status: "failure",
      error: e.message
    )
  end
end