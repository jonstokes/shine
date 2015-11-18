class DeleteAssetFromRequest
  include Troupe

  expects :params

  def call
    record = Asset.find_by(cid: cid)
    context.fail!(error: 'record_not_found') and return unless record
    record.destroy
  end

  def cid
    @cid ||= params['sys']['id']
  end
end