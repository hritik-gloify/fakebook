class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = @user.posts.build
    @comments = Comment.all
  end

  def index
    @users = User.all_except(current_user)
    @friendships = current_user.friendships
    @inverse_friendships = current_user.inverse_friendships
  end

  def log_out
    reset_session
    current_user = nil
    respond_to do |format|
      if current_user == nil
        format.html { redirect_to unauthenticated_root_path, notice: "Logged Out!" }
      else
        format.html { redirect_to authenticated_root_path, notice: "Try again!" }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :age, :username, :profile_picture, :email, :interest)
  end
end