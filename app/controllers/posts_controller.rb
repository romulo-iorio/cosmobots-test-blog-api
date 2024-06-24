class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show update destroy like dislike ]

  def index
    @posts = Post.all.sort_by(&:created_at).reverse
    render json: { posts: nest_post_relations(@posts) }
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: nest_post_relations(@post) }
  end

  def create
    @new_post = { title: post_params[:title], content: post_params[:content], user: current_user }

    @post = Post.new(@new_post)

    @saved_post = @post.save()

    return return_errors() if not @saved_post

    render json: { post: nest_post_relations(@post) }, status: :created
  end

  def update
    # authorize current_user, @post

    @updated_post = @post.update(post_params)

    return return_errors() if not @updated_post

    render json: { post: @post }, status: :ok
  end

  def destroy
    # authorize current_user, @post

    @post.destroy
  end

  def like
    @dislike = Dislike.where(user_id: current_user.id, post_id: @post.id).first
    @like = Like.where(user_id: current_user.id, post_id: @post.id).first

    if @like
      @like.destroy
    else
      @like = Like.new(user_id: current_user.id, post_id: @post.id)
      @like.save
      @dislike.destroy if @dislike
      render json: @like, status: :ok
    end
  end

  def dislike
    @dislike = Dislike.where(user_id: current_user.id, post_id: @post.id).first
    @like = Like.where(user_id: current_user.id, post_id: @post.id).first

    if @dislike
      @dislike.destroy
    else
      @dislike = Dislike.new(user_id: current_user.id, post_id: @post.id)
      @dislike.save
      @like.destroy if @like
      render json: @dislike, status: :ok
    end
  end  

  private
      def set_post
        @post = Post.where(id: params[:id]).first
      end

      def post_params
        params.require(:post).permit(:title, :content)  
      end

      def return_errors
        render json: { error: @post.errors }, status: :unprocessable_entity 
      end

      def nest_post_relations(post)
        post.as_json(include: [:user, comments: { include: :user }, likes: { include: :user }, dislikes: { include: :user }])
      end
end
