class FollowsController < ApplicationController
  def follow
    puts params
    @user = User.find_by! nickname: params[:nickname]
    if current_user.follow @user.id
      respond_to do |format|
        format.html {
          redirect_to(root_path,
                        notice: "You have successfully follow")
        }
        format.js
      end
    end
  end

  def unfollow
    @user = User.find_by! nickname: params[:nickname]
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html {
          redirect_to(root_path,
                        notice: "You have successfully unfollow")
        }
        format.js
      end
    end
  end
end
