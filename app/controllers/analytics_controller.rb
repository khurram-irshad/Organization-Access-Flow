class AnalyticsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_organization
  
    def organization
      authorize @organization, :show?
      @user_count = @organization.users.count
      @role_counts = @organization.users.joins(:roles).group("roles.name").count
      @content_counts = @organization.contents.group(:content_rating).count
    end
  
    private
  
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
  end