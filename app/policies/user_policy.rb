class UserPolicy < ApplicationPolicy
  def update?
    is_owner?
  end

  def edit?
    is_owner?
  end

  def is_owner?
    user == record
  end
end