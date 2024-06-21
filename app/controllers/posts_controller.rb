class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show update destroy ]

  def index
    @posts = Post.all
    render json: { posts: @posts }
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: @post }
  end

  def create
    @new_post = { title: post_params[:title], content: post_params[:content], user: current_user }

    @post = Post.new(@new_post)

    @saved_post = @post.save()

    return return_errors() if not @saved_post
      
    render json: { post: @post }, status: :created
  end

  def update
    @updated_post = @post.update(post_params)

    return return_errors() if not @updated_post

    render json: @post
  end

  def destroy
    @post.destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def return_errors
      render json: { error: @post.errors }, status: :unprocessable_entity
    end
end
