class LikesController < ApplicationController

  def create
    @like = Like.new(likes_params)
    @like.user_id = current_user.id
    unless @like.save
      flash[:notice] = @like.errors.full_message.to_sentence
    end
    redirect_back_or_to(posts_path)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back_or_to(posts_path)
  end

  private

  def likes_params
    params.require(:like).permit(:post_id)
  end
end
