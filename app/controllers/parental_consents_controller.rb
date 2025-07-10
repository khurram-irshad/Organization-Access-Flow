class ParentalConsentsController < ApplicationController
    before_action :set_parental_consent, only: [:show, :update]
  
    def show
      # Show the consent approval page
    end
  
    def update
      status_value = case params[:status]
                     when "approved"
                       ParentalConsent::STATUS_APPROVED
                     when "denied"
                       ParentalConsent::STATUS_DENIED
                     else
                       ParentalConsent::STATUS_PENDING
                     end
  
      if @parental_consent.update(status: status_value)
        redirect_to root_path, notice: "Consent #{params[:status]}."
      else
        render :show
      end
    end
  
    private
  
    def set_parental_consent
      @parental_consent = ParentalConsent.find_by(token: params[:id])
      redirect_to root_path, alert: "Invalid consent link." unless @parental_consent
    end
  end