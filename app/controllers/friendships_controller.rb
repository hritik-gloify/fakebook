class FriendshipsController < ApplicationController
    before_action :find_friendship, only: [:destroy, :edit]
  
    def new
      @friendships = Friendship.new
    end
  
    def create
      user = User.find(params[:id])
      @friendship = Friendship.create(user_id: current_user.id, friend_id: user.id, friendship_status: false)
      respond_to do |format|
        if @friendship.save
          format.html { redirect_to users_path, notice: "Friendship request sent successfully!" }
        else
          format.html { redirect_to users_path, notice: "Cannot send friendship request!" }
        end
      end
    end
  
    def edit
      respond_to do |format|
        if @friendship_id
          @friendship_id.update_attribute(:friendship_status, true)
          format.html { redirect_to users_path, notice: "Friendship request accepted!" }
        else
          format.html { redirect_to users_path, notice: "Friendship request not accepted!" }
        end
      end
    end
  
    def destroy
      respond_to do |format|
        if @friendship_id
          @friendship_id.destroy
          format.html { redirect_to users_path, notice: "Friendship request rejected!" }
        else
          format.html { redirect_to users_path, notice: "Friendship request NOT canceled" }
        end
      end
    end
  
    private
  
    def find_friendship
      @friendship_id = Friendship.find(params[:id])
    end
  end