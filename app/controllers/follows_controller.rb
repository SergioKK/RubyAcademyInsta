class FollowsController < ApplicationController
  def follow
    puts params
    @user = User.find_by! name: params[:name]
    if current_user.follow @user.id
      respond_to do |format|
        format.html { redirect_back(fallback_location: :current_page) }
        format.js
      end
    end
  end

  def unfollow
    @user = User.find_by! name: params[:name]
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html { redirect_back(fallback_location: :current_page) }
        format.js
      end
    end
  end
end
