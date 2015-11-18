class RunSyncSession
  include Troupe

  attr_reader :sync_session

  permits(:initial) { false }

  def call
    return if SyncSession.sync_in_progress?
    @sync_session = SyncSession.create(status: "started")

    # TODO: Lock the posts table for this
    # Upsert all the entries in the delta list to the db
    Content.sync_each_item(initial: initial) do |item|
      content_type_id = item.respond_to?(:content_type) ? item.content_type.id : nil
      klass = Content.cid_to_class_name(content_type_id).constantize
      attrs = map_object(klass: klass, item: item)
      if record = klass.find_by(cid: attrs[:cid])
        record.update(attrs)
      else
        klass.create(attrs)
      end
    end

    # Delete any deleted entries or assets
    Content.sync_each_deletion(initial: initial) do |item|
      content_type_id = item.respond_to?(:content_type) ? item.content_type.id : nil
      klass = Content.cid_to_class_name(content_type_id).constantize
      klass.find_by(cid: item.id).destroy
    end

    sync_session.update(status: "success")
  rescue Contentful::Error => e
    sync_session.update(
      status: "failure",
      error: e.message
    )
  end

  def map_object(klass:, item:)
    mapper = "#{klass.name}::ObjectMapper".constantize.new(item)
    mapper.to_hash.merge(sync_session_id: sync_session.id)
  end
end