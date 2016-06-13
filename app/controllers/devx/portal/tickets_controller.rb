require_dependency "devx/application_controller"

module Devx
  class Portal::TicketsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :ticket, class: 'Devx::Ticket'
    load_and_authorize_resource :ticket_update, class: 'Devx::TicketUpdate'
    layout 'devx/portal'

    def index
    end

    def new
    end

    def create
      @ticket.user = current_user
      
      if @ticket.valid? && @ticket.save
        redirect_to devx.portal_tickets_path,
        notice: "Successfully created ticket"
      else
        render :new,
        notice: "Failed to create ticket"
      end
    end

    def update
    end


    private

    def ticket_params
      accessible = [ :user, :summary, :description, :location, :severity, :status ]
      params.require(:ticket).permit(accessible)
    end
  end
end
