class RequestMapper
  attr_reader :params, :cid

  def initialize(params)
    @params = params
    @cid = params['sys']['id']
  end

  private

  def field(name)
    params['fields'][name.to_s][Content.locale]
  end

  def extract_object_cid(obj)
    obj['sys']['id']
  end

  def extract_object_cids(object_list)
    object_list.map do |obj|
      extract_object_cid obj
    end
  end
end
