module UsersHelper
  def current_user_check(user)
    current_user.id == user.id
  end
end