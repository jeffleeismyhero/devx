require_dependency "devx/application_controller"

module Devx
  class Portal::DonationsController < ApplicationController
    before_filter :authenticate_user!, except: :donate
    load_and_authorize_resource :donation, class: 'Devx::Donation'
    layout 'devx/portal'

    def index
      # TODO
    end

    def create
      # render plain: @donation.inspect
      # return
      if @donation.valid?
        exp_date = "%02d%02d" % [params['expiry_date(2i)'], params['expiry_date(1i)'].last(2)]
        if app_settings['diamond_mind'].present?
          if DiamondMind::Processor.process(current_user, @donation, params['cc_number'], exp_date, params['cvv']) == 'Approved'
            @donation.save
            redirect_to devx.portal_donate_path,
            notice: "Your donation has been successfully processed"
          else
            render :donate,
            notice: "An error occurred during processing"
          end
        else
          render plain: 'No payment processor is enabled'
          return
        end
      end
    end

    def donate
      @donation = Devx::Donation.new
    end


    private

    def donation_params
      accessible = [ :amount, :cardholder_first_name, :cardholder_last_name, :billing_address, :city, :state, :zip_code, :affiliation,
                    :phone_number, :class_participation, :company_match, :company_name, :company_email_to_notify ]
      params.require(:donation).permit(accessible)
    end
  end
end
