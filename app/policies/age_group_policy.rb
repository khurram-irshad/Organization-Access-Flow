class AgeGroupPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.age_group == record || user.has_role?(:admin)
  end
end