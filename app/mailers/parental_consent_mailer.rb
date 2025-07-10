class ParentalConsentMailer < ApplicationMailer
    def consent_request(user, parent_email)
      @user = user
      @consent_url = parental_consents_url
      mail(to: parent_email, subject: "Parental Consent Request for #{@user.email}")
    end
  end