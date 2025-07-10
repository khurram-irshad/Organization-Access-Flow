class OrganizationMembershipPolicy < ApplicationPolicy
  def create?
    # Allow users to join organizations they're not already members of
    user.present? && !user.organizations.include?(record.organization)
  end

  def destroy?
    # Allow admins to remove members, or users to leave organizations
    user.present? && (
      user.has_role?(:admin, record.organization) || 
      record.user == user
    )
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.has_role?(:admin)
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end