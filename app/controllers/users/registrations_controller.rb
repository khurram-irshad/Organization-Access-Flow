# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Pundit::Authorization

  def create
    super do |resource|
      if resource.persisted? && resource.minor?
        ParentalConsent.create(user: resource, parent_email: params[:user][:parent_email])
        ParentalConsentMailer.consent_request(resource, params[:user][:parent_email]).deliver_later
      end
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :parent_email)
  end
end