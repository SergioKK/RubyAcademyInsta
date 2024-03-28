class LikesController < ApplicationController

  def create
    @like = current_user.likes.new(likes_params)
    if !@like.save
      flash[:notice] = @like.errors.full_message.to_sentence
    end

    redirect_back(fallback_location: :current_page)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: :current_page)
  end

  private

  def likes_params
    params.require(:like).permit(:post_id)
  end
end
