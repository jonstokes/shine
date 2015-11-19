class MakeDeleteChanges
  include Troupe
  include SyncIterator

  provides(:sync_session) do
    SyncSession.create(status: "started", mode: "delete")
  end

  def call
    sync_each_item(sync_session: sync_session) do |item|
      item.klass.find_by(cid: item.id).try(:destroy)
    end
    sync_session.update(status: "success")
  rescue Contentful::Error => e
    sync_session.update(
      status: "failure",
      error: e.message
    )
  end
end