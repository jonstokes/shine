module Shine
  module PostsHelper
    def row_class(post)
      case post.status
      when "pending"
        "class=success"
      when "draft"
        "class=warning"
      end
    end
  end
end
