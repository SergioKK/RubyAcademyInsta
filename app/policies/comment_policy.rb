class CommentPolicy < ApplicationPolicy
  def update?
    is_owner?
  end

  def delete?
    update?
  end

  def is_owner?
    user == record.user
  end
end