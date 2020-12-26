class CategoryPolicy < ApplicationPolicy
    def create?
      return true if user.admin?
      false
    end
  
    def update?
      return true if user.admin? or user.simple_user?
      false
    end
  
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
  