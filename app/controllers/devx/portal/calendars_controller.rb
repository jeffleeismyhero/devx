require_dependency "devx/application_controller"

module Devx
  class Portal::CalendarsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource :calendar, class: 'Devx::Calendar'
    layout 'devx/portal'

    def index
        @q = @calendars.search(params[:q])
        @q.sorts = 'name asc' if @q.sorts.empty?
        @calendars = @q.result(distinct: true)
    end

    def show
        if @calendar.calendar_type == 'Google Calendar'
            @google_events = @calendar.get_google_events
        end
    end

    def new
    end

    def edit
    end

    def create
        if @calendar.valid? && @calendar.save
            redirect_to devx.edit_portal_calendar_path(@calendar),
            notice: "Successfully saved calendar"
        else
            render :new,
            notice: "Failed to save calendar"
        end
    end

    def update
        if @calendar.valid? && @calendar.update(calendar_params)
            redirect_to devx.edit_portal_calendar_path(@calendar),
            notice: "Successfully updated calendar"
        else
            render :edit,
            notice: "Failed to update calendar"
        end
    end

    def destroy
        if @calendar.destroy
            redirect_to devx.portal_calendars_path,
            notice: "Successfully deleted calendar"
        else
            redirect_to devx.portal_calendars_path,
            notice: "Failed to delete calendar"
        end
    end


    def import
      require 'csv'

      @calendar = 

      @import = Devx::Import.new(params[:import])
      @errors = 0;

      if request.post?

        if @import.valid?

          if records = CSV.read(@import.file.path, headers: true)
            logfile = File.open("#{Rails.root}/log/import.log", "a")
            logfile.sync = true
            logger = Logger.new(logfile)

            records.each_with_index do |record, index|

              name = record[0].to_s.squish
              start_time = record[1].to_s.squish
              end_time = record[2].to_s.squish
              description = record[3].to_s.squish
              location = record[4].to_s.squish
              contact_name = record[5].to_s.squish

              event = Devx::Event.new(
                calendar_id: @calendar.id,
                name: name,
                description: description,
                start_time: start_time.to_datetime,
                end_time: end_time.to_datetime,
                location: location,
                contact_name: contact_name
              )

              if event.valid?
                logger.info "Expecting object to be valid: #{event.inspect}"
                event.save
              else
                logger.warn "Failed to import object: #{event.inspect}"
                event.errors.full_messages.try(:each) do |error|
                  logger.warn "#{error}"
                end
                @errors += 1
              end

            end

          end

        end

        if @errors > 0
          redirect_to devx.portal_articles_path,
          notice: "#{@errors} article(s) could not be imported due to errors"
        else
          redirect_to devx.portal_articles_path,
          notice: "All articles imported successfully"
        end

      end
    end


    private

    def calendar_params
        accessible = [ :name, :calendar_type, :client_id, :client_secret, :google_calendar_id, :authorization_code, :time_zone, :active ]
        params.require(:calendar).permit(accessible)
    end
  end
end


