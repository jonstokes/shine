class UpsertItem
  include Troupe

  expects :item
  permits :sync_session_id

  provides(:attrs) do
    a = klass.item_to_attributes(item)
    a.merge!(sync_session_id: sync_session_id) if sync_session_id
    a
  end

  def call
    if record = klass.find_by(cid: attrs[:cid])
      record.update(attrs)
    else
      klass.create(attrs)
    end
  end

  def klass
    item.klass
  end
end