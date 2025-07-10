class Users::RegistrationsController < Devise::RegistrationsController
  include Pundit::Authorization

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    resource.age_group = assign_age_group(resource.date_of_birth)

    if resource.age_group.nil?
      resource.errors.add(:date_of_birth, "is invalid or no matching age group found")
      clean_up_passwords resource
      set_minimum_password_length
      render :new, status: :unprocessable_entity
      return
    end

    if resource.kid? && sign_up_params[:parent_email].blank?
      resource.errors.add(:parent_email, "is required for users under 13")
      clean_up_passwords resource
      set_minimum_password_length
      render :new, status: :unprocessable_entity
      return
    end

    if resource.kid? && sign_up_params[:parent_email].present?
      unless sign_up_params[:parent_email].match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
        resource.errors.add(:parent_email, "is not a valid email address")
        clean_up_passwords resource
        set_minimum_password_length
        render :new, status: :unprocessable_entity
        return
      end
    end

    unless resource.save
      clean_up_passwords resource
      set_minimum_password_length
      render :new, status: :unprocessable_entity
      return
    end

    if resource.persisted?
      if resource.kid?
        begin
          consent = ParentalConsent.create!(
            user: resource,
            parent_email: sign_up_params[:parent_email],
            status: ParentalConsent::STATUS_PENDING
          )
          ParentalConsentMailer.consent_request(resource, sign_up_params[:parent_email]).deliver_later
          set_flash_message! :notice, :signed_up_but_unconfirmed
          redirect_to root_path, notice: "Registration pending parental consent. Check your parent's email for verification."
        rescue ActiveRecord::RecordInvalid => e
          resource.destroy # Roll back user creation
          resource.errors.add(:base, "Failed to create parental consent record: #{e.message}")
          clean_up_passwords resource
          set_minimum_password_length
          render :new, status: :unprocessable_entity
          return
        end
      else
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: root_path
        else
          set_flash_message! :notice, :signed_up_but_unconfirmed
          expire_data_after_sign_in!
          respond_with resource, location: root_path
        end
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :parent_email)
  end

  def assign_age_group(date_of_birth)
    return nil unless date_of_birth.is_a?(Date)
    today = Date.today
    age = today.year - date_of_birth.year
    if today.month < date_of_birth.month || (today.month == date_of_birth.month && today.day < date_of_birth.day)
      age -= 1
    end
    age_group = AgeGroup.find_by("min_age <= ? AND max_age >= ?", age, age)
    age_group
  end
end