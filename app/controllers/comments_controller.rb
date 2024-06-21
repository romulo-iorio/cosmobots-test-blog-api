class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: %i[ update destroy ]

    def index
        @comments = Comment.all
        render json: { comments: @comments }
    end

    def show
        @comments = Comment.where(post_id: params[:id])
        render json: { comments: @comments }
    end

    def create
        @post = Post.find(comment_params[:post_id])

        @new_comment = { content: comment_params[:content], post: @post, user: current_user }

        @comment = Comment.new(@new_comment)

        @saved_comment = @comment.save()

        return return_errors() if not @saved_comment

        render json: { comment: @comment }, status: :created
    end

    def update
        @updated_comment = @comment.update(comment_params)

        return return_errors() if not @updated_comment

        render json: @comment
    end

    def destroy
        @comment.destroy
    end

    private
        def set_comment
            @comment = Comment.find(params[:id])
        end

        def comment_params
            params.require(:comment).permit(:content, :post_id)
        end

        def return_errors
            render json: { error: @comment.errors }, status: :unprocessable_entity
        end
    end
