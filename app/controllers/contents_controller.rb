class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: [:show]
  include Pundit::Authorization

  def index
    @contents = Content.all.policy_scope(Content)
  end

  def show
    authorize @content
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end
end