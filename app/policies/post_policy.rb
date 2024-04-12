class PostPolicy < ApplicationPolicy
  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  def is_owner?
    user == record.user
  end
end