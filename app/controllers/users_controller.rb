class UsersController < ApplicationController
  include Pundit::Authorization

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.minor?
        ParentalConsent.create(user: @user, parent_email: params[:user][:parent_email])
        ParentalConsentMailer.consent_request(@user, params[:user][:parent_email]).deliver_later
        redirect_to root_path, notice: "Registration pending parental consent."
      else
        redirect_to root_path, notice: "Registration successful."
      end
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :parent_email)
  end
end