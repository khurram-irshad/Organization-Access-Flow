class ContentPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.joins(:organization).where(organizations: { id: user.organization_ids })
      end
    end
  
    def show?
      user.organizations.include?(record.organization) &&
        (record.content_rating.in?(allowed_ratings))
    end
  
    private
  
    def allowed_ratings
      case user.age_group&.name
      when "Kids" then ["G"]
      when "Teens" then ["G", "PG-13"]
      else ["G", "PG-13", "R"]
      end
    end
  end