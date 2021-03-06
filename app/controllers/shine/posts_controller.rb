require_dependency "shine/application_controller"

module Shine
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts
    def index
      @posts = if params[:status]
        @subtitle = params[:status].capitalize
        Shine::Post.where(status: params[:status].downcase)
      else
        @subtitle = 'All'
        Shine::Post.all
      end
    end

    # GET /posts/1
    def show
    end

    # GET /posts/new
    def new
      @post = Shine::Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    def create
      @post = Shine::Post.new(post_params)

      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Shine::Post.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def post_params
        params[:post].permit(Shine::Post.attribute_names)
      end
  end
end
