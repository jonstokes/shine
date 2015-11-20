module Shine
  class ContentfulController < ActionController::Base

    def sync
      return unless request.headers['X-Contentful-Topic']

      if item.record?
        Shine::UpsertContentItem.call(item: item)
      else
        Shine::DeleteContentItem.call(item: item)
      end

      respond_to do |format|
        format.json { render json: "OK" }
      end
    end

    def item
      Shine::Item.new(params)
    end
  end
end