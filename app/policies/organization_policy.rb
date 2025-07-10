class OrganizationPolicy < ApplicationPolicy
  def index?
    user.has_role?(:admin) || user.has_role?(:member, Organization)
  end

  def show?
    user.has_role?(:admin) || user.has_role?(:member, record)
  end

  def create?
    user.has_role?(:admin)
  end

  def update?
    user.has_role?(:admin)
  end

  def destroy?
    user.has_role?(:admin)
  end
end