class ObjectMapper
  attr_reader :object, :cid

  def initialize(object)
    @object = object
    @cid = object.id
  end

  private

  def field(name)
    object.fields[name]
  end

  def extract_object_cid(obj)
    obj.id
  end

  def extract_object_cids(object_list)
    object_list.map do |obj|
      extract_object_cid obj
    end
  end
end