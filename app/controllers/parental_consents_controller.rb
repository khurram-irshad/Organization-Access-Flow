class ParentalConsentsController < ApplicationController
    before_action :set_parental_consent, only: [:show, :update]
  
    def show
    end
  
    def update
      status_param = params[:status] || params.dig(:parental_consent, :status)
      
      status_value = case status_param
                     when "approved"
                       ParentalConsent::STATUS_APPROVED
                     when "denied"
                       ParentalConsent::STATUS_DENIED
                     else
                       ParentalConsent::STATUS_PENDING
                     end
  
      Rails.logger.debug "Updating consent status to: #{status_param} (#{status_value})"
  
      if @parental_consent.update(status: status_value)
        redirect_to root_path, notice: "Consent #{status_param}."
      else
        Rails.logger.error "Failed to update consent: #{@parental_consent.errors.full_messages}"
        render :show
      end
    end
  
    private
  
    def set_parental_consent
      @parental_consent = ParentalConsent.find_by(token: params[:id])
      unless @parental_consent
        redirect_to root_path, alert: "Invalid consent link."
      end
    end
  end