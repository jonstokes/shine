class SyncEntryFromRequest
  include Troupe

  expects :item

  def call
    if record = klass.find_by(cid: attrs[:cid])
      record.update(attrs)
    else
      record = klass.create(attrs)
    end

    context.fail!(error: record.errors) unless record.valid?
  end

  def attrs
    @attrs ||= item.convert_to_attributes_hash
  end

  def klass
    item.klass
  end
end