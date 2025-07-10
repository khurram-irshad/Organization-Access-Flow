class ParentalConsentMailer < ApplicationMailer
    def consent_request(user, parent_email)
      @user = user
      @consent = ParentalConsent.find_by(user: user, parent_email: parent_email)
      mail(to: parent_email, subject: "Parental Consent Request for #{@user.first_name}")
    end
  end
  