class ContentPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def show?
      return true if user.has_role?(:admin)
      return false unless user.organizations.include?(record.organization)
      case record.content_rating
      when "G"
        true
      when "PG-13"
        user.age_group&.name&.in?(%w[Teens Adults])
      when "R"
        user.age_group&.name == "Adults"
      else
        false
      end
    end
  end