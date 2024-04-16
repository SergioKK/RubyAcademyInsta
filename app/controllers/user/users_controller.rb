class User::UsersController < ApplicationController
  def user_posts
    @user = User.find(params[:user_id])
    @posts = Post.where(user: @user).order(created_at: :desc)
  end

  def profile
    @posts = Post.where(user: current_user).order(created_at: :desc)
    @followers = current_user.followers
    @followings = current_user.following
  end

  def feed
    @posts = Post.followers current_user.following
    @followings = current_user.following
  end

  private

  def user_params
    params.require(:user).permit(:user_id, :image)
  end
end