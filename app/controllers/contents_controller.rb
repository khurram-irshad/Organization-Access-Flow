class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_platform_access
  before_action :set_content, only: [:show]
  include Pundit::Authorization

  def index
    if current_user.organization_ids.empty?
      flash[:alert] = "Please join an organization to view contents."
      redirect_to organizations_path
      return
    end
    @contents = policy_scope(Content).where(content_rating: allowed_ratings)
  end

  def show
    authorize @content
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end

  def check_platform_access
    unless current_user.can_access_platform?
      if current_user.kid?
        flash[:alert] = "Your account is pending parental consent. Please check your parent's email."
      else
        flash[:alert] = "Your account access is restricted."
      end
      redirect_to root_path
    end
  end

  def allowed_ratings
    case current_user.age_group&.name
    when "Kids" then ["G"]
    when "Teens" then ["G", "PG-13"]
    else ["G", "PG-13", "R"]
    end
  end
end