class UsersController < ApplicationController
  include Pundit::Authorization

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.age_group = assign_age_group(@user.date_of_birth)
    if @user.age_group.nil?
      @user.errors.add(:date_of_birth, "is invalid or no matching age group found")
      render :new, status: :unprocessable_entity
      return
    end
    if @user.minor? && params[:user][:parent_email].blank?
      @user.errors.add(:parent_email, "is required for minors")
      render :new, status: :unprocessable_entity
      return
    end
    if @user.save
      if @user.minor?
        ParentalConsent.create(user: @user, parent_email: params[:user][:parent_email], status: "pending")
        ParentalConsentMailer.consent_request(@user, params[:user][:parent_email]).deliver_later
        redirect_to root_path, notice: "Registration pending parental consent."
      else
        redirect_to root_path, notice: "Registration successful."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :parent_email)
  end

  def assign_age_group(date_of_birth)
    return nil unless date_of_birth.is_a?(Date)
    today = Date.today
    age = today.year - date_of_birth.year - ((today.month > date_of_birth.month || (today.month == date_of_birth.month && today.day >= date_of_birth.day)) ? 0 : 1)
    age_group = AgeGroup.find_by("min_age <= ? AND max_age >= ?", age, age)
    age_group
  end
end