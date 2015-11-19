class ItemMapper
  attr_reader :item

  delegate :id, to: :item

  def initialize(item)
    @item = item
  end

  def field(name)
    item.field(name)
  end

  def extract_cids(object_list)
    object_list.map do |obj|
      extract_cid obj
    end
  end

  def extract_cid(obj)
    obj['sys']['id']
  end
end