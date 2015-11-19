class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      slug = "#{params[:year]}/#{params[:month]}/#{params[:day]}/#{params[:slug]}"
      @post = Post.find_by(slug: slug)
    end
end
