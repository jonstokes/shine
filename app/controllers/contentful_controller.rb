class ContentfulController < ActionController::Base

  def webhook
    return unless request.headers['X-Contentful-Topic']

    raw_item = JSON.parse(response.body)
    item = Contentful::Item.new(raw_item)

    if item.record?
      UpsertItem.call(item: item)
    else
      DeleteItem.call(item: item)
    end

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end
end
