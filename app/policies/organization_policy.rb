class OrganizationPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present? && !user.kid?
  end

  def new?
    create?
  end

  def update?
    user.present? && user.has_role?(:admin, record)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.has_role?(:admin, record)
  end

  class Scope < ApplicationPolicy::Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user&.has_role?(:admin)
        @scope.all
      else
        @scope.all
      end
    end
  end
end