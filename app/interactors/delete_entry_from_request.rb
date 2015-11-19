class DeleteEntryFromRequest
  include Troupe

  expects :item

  def call
    context.fail!(error: 'record_not_found') and return unless record
    record.destroy
  end

  def record
    Post.find_by(cid: item.id) ||
      Author.find_by(cid: item.id) ||
      Category.find_by(cid: item.id)
  end
end