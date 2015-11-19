class DeleteItem
  include Troupe

  expects :item

  def call
    record = Post.find_by(cid: item.id) ||
      Author.find_by(cid: item.id) ||
      Category.find_by(cid: item.id) ||
      Asset.find_by(cid: item.id)

    record.try(:destroy)
  end
end