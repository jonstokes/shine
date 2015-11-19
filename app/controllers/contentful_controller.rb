class ContentfulController < ActionController::Base

  def webhook
    return unless request.headers['X-Contentful-Topic']

    if item.record?
      UpsertContentItem.call(item: item)
    else
      DeleteContentItem.call(item: item)
    end

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end

  def item
    Contentful::Item.new(params)
  end
end
