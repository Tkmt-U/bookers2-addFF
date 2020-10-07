class RelationshipsController < ApplicationController

  def create
    follow = current_user.active_relationship.new(followed_id: params[:user_id])
    follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.active_relationship.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end

  def follows
    @user = User.find(params[:user_id])
    @users = @user.follower
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followed
  end

end
