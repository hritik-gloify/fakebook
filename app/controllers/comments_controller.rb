class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:destroy, :create]
    before_action :get_post
  
    def index
      @comments = @post.comments
    end
  
    def create
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      @comment.post_id = params[:post_id]
      respond_to do |format|
        if @comment.save
          format.html { redirect_to authenticated_root_path, notice: "Comment created!" }
        else
          format.html { redirect_to authenticated_root_path, notice: "Cannot create comment!" }
        end
      end
    end
  
    def destroy
      @comment = @post.comments.find(params[:id])
      respond_to do |format|
        if @comment.destroy
          format.html { redirect_to authenticated_root_path, notice: "Comment deleted!" }
        else
          format.html { redirect_to authenticated_root_path, notice: "Cannot delete comment!" }
        end
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  
    def get_post
      @post = Post.find(params[:post_id])
    end
  end