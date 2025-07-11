class OrganizationMembershipPolicy < ApplicationPolicy
  def create?
    user.present? && 
    !user.organizations.include?(record.organization) &&
    user.can_access_platform?
  end

  def destroy?
    user.present? && (
      record.user == user || 
      user.has_role?(:admin, record.organization)
    )
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.has_role?(:admin)
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end