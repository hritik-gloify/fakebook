class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:destroy, :create]
  
    def index
      @post = Post.new
      @posts = current_user.friends_and_own_posts
    end
  
    def create
      @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to authenticated_root_path, notice: "Post Created!" }
        else
          format.html { redirect_to authenticated_root_path, notice: "Try again!" }
        end
      end
    end
  
    def edit
    end
  
    def destroy
      @post = current_user.posts.find_by(id: params[:id])
      @post.destroy
      respond_to do |format|
        format.html { redirect_to current_user, notice: "Post deleted!" }
      end
   end
  
    private
  
    def post_params
      params.require(:post).permit(:content, :image)
    end
  end