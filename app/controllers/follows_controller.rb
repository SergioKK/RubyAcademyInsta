class FollowsController < ApplicationController
  def follow
    @user = User.find_by! nickname: params[:nickname]
    respond_to do |format|
      if current_user.id == @user.id
        format.html { redirect_to(root_path, alert: 'You cannot follow yourself') }
        format.js
      elsif current_user.follow @user.id
        format.html { redirect_to(root_path, notice: "You have successfully follow #{@user.nickname}") }
        format.js
      end
    end
  end

  def unfollow
    @user = User.find_by! nickname: params[:nickname]
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html { redirect_to(root_path, notice: "You have successfully unfollow #{@user.nickname}") }
        format.js
      end
    end
  end
end
