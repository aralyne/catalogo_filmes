class MoviePolicy < ApplicationPolicy
  def create?
    return true if user.admin?
    false
  end

  def update?
    return true if user.admin? or record.user_id == user.id
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
