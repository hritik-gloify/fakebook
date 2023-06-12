class LikesController < ApplicationController
    def create
      @like = Like.new(user_id: current_user.id)
      respond_to do |format|
        if @like
          @like = @likeable.likes.create(user_id: current_user.id)
          format.html { redirect_to authenticated_root_path }
        else
          format.html { redirect_to authenticated_root_path, notice: "Already Liked!" }
        end
      end
    end
  
    def destroy
      @like_id = @likeable.likes.find(params[:id])
      respond_to do |format|
        if @like_id
          @like_id.destroy
          format.html { redirect_to authenticated_root_path }
        else
          format.html { redirect_to authenticated_root_path, notice: "Cannot Unlike!" }
        end
      end
    end
  end