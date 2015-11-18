class ContentfulController < ActionController::Base

  def webhook
    return unless topic_header = request.headers['X-Contentful-Topic']

    if topic_header[/Entry/]
      interactor = if topic_header[/unpublish/]
        DeleteEntryFromRequest.call(params: params)
      else
        SyncEntryFromRequest.call(params: params)
      end
    elsif topic_header[/Asset/]
      interactor = if topic_header[/unpublish/]
        DeleteAssetFromRequest.call(params: params)
      else
        SyncAssetFromRequest.call(params: params)
      end
    end

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end
end
