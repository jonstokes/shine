class DeleteAssetFromRequest
  include Troupe

  expects :item

  def call
    record = Asset.find_by(cid: item.id)
    context.fail!(error: 'record_not_found') and return unless record
    record.destroy
  end
end