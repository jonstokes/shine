module Shine
  class ContentfulController < ActionController::Base
    before_filter { request.format = :json }

    def sync
      if item.record?
        Shine::UpsertContentItem.call(item: item)
      else
        Shine::DeleteContentItem.call(item: item)
      end

      render nothing: true
    end

    def item
      Shine::Item.new(webhook_params)
    end

    def webhook_params
      JSON.parse request.raw_post
    end
  end
end