class SyncAssetFromRequest
  include Troupe

  expects :params

  def call
    if record = Asset.find_by(cid: attrs[:cid])
      record.update(attrs)
    else
      record = Asset.create(attrs)
    end

    context.fail!(error: record.errors) unless record.valid?
  end

  def attrs
    @attrs ||= Asset::RequestMapper.new(params).to_hash
  end
end