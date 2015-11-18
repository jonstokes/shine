class DeleteEntryFromRequest
  include Troupe

  expects :params

  def call
    context.fail!(error: 'record_not_found') and return unless record
    record.destroy
  end

  def record
    Post.find_by(cid: cid) ||
      Author.find_by(cid: cid) ||
      Category.find_by(cid: cid)
  end

  def cid
    @cid ||= params['sys']['id']
  end
end