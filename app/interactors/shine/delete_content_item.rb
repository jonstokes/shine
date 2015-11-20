module Shine
  class DeleteContentItem
    include Troupe

    expects :item

    def call
      record = Shine::Post.find_by(cid: item.id) ||
        Shine::Author.find_by(cid: item.id) ||
        Shine::Category.find_by(cid: item.id) ||
        Shine::Asset.find_by(cid: item.id)

      record.try(:destroy)
    end
  end
end