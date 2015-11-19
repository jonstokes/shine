class UpsertContentItem
  include Troupe

  expects :item
  permits :sync_session_id

  def call
    attrs = klass.item_to_attributes(item)
    attrs.merge!(sync_session_id: sync_session_id) if sync_session_id
    
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