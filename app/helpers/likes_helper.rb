module LikesHelper
  def like_count(post)
    Like.where(post_id: post[:id]).count
  end

  # returns instance of like
  def current_user_liked_a_post(post)
    current_user&.likes&.find_by(post: post)
  end
end
