module Shine
  class SessionsController < Devise::SessionsController
    layout 'application'

    def after_sign_in_path_for(resource)
      stored_location_for(resource) ||
        if resource.is_a?(User)
          '/shine/posts'
        else
          super
        end
    end

    def after_sign_out_path_for(resource)
      if resource == :user
        "/"
      else
        super
      end
    end

  end
end