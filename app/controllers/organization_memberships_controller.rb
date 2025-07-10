class OrganizationMembershipsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_organization
    include Pundit::Authorization
  
    def create
      @membership = OrganizationMembership.new(user: current_user, organization: @organization)
      authorize @membership
      
      if @membership.save
        current_user.add_role(:member, @organization)
        redirect_to @organization, notice: "Joined organization successfully."
      else
        redirect_to @organization, alert: "Failed to join organization."
      end
    end
  
    def destroy
      @membership = @organization.organization_memberships.find_by(user: current_user)
      authorize @membership if @membership
      
      if @membership&.destroy
        current_user.remove_role(:member, @organization)
        redirect_to organizations_path, notice: "Left organization successfully."
      else
        redirect_to @organization, alert: "Failed to leave organization."
      end
    end
  
    private
  
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
  end