class User::UsersController < ApplicationController
  def user_posts
    @user = User.find(params[:user_id])
    @posts = Post.where(user: @user).order(created_at: :desc)
  end

  def user_profile
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :nickname, :user_id)
  end
end