class SyncAssetFromRequest
  include Troupe

  expects :item

  def call
    if record = Asset.find_by(cid: attrs[:cid])
      record.update(attrs)
    else
      record = Asset.create(attrs)
    end

    context.fail!(error: record.errors) unless record.valid?
  end

  def attrs
    @attrs ||= item.convert_to_attributes_hash
  end
end