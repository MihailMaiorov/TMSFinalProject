class ReviewPolicy < ApplicationPolicy
  def update?
    user.has_role?(:user) && record.user_id == user.id
  end

  def create?
    user.has_role?(:user)
  end

  def archive?
    user.has_role?(:user)
  end
end
