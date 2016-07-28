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
          #@events = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
          @schedules = Devx::Schedule.coming_up
          @q = @schedules.search(params[:q])
          @q.sorts = 'start_time asc'
          @schedules = @q.result.ordered.paginate(page: params[:page])
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

      @import = Devx::Import.new(params[:import])
      @errors = 0;

      if request.post?

        if @import.valid?

          if records = CSV.read(@import.file.path, headers: true)
            logfile = File.open("#{Rails.root}/log/import.log", "a")
            logfile.sync = true
            logger = Logger.new(logfile)

            records.each_with_index do |record, index|

              ## Event details
              name = record[0].to_s.squish
              description = record[1].to_s.squish

              if record[2].present? && record[2] != 'NULL'
                category = record[2].to_s.squish
              end
              
              location = record[3].to_s.squish
              contact_name = record[4].to_s.squish
              contact_email = record[5].to_s.squish
              private_event = record[6].to_s.squish

              ## Event schedule
              if record[9] != 'NULL'
                start_time = "#{record[7].to_date} #{record[9].to_datetime.strftime('%H:%M:%S')}"
              else
                start_time = "#{record[7].to_date} 00:00:00"
              end

              if record[10] != 'NULL'
                end_time = "#{record[8].to_date} #{record[10].to_datetime.strftime('%H:%M:%S')}"
              else
                end_time = "#{record[8].to_date} 11:59:59"
              end

              if record[11] == '0'
                all_day = false
              elsif (record[11] == '1') || (start_time.to_datetime.strftime('%H:%M:%S') == '00:00:00' && end_time.to_datetime.strftime('%H:%M:%S') == '11:59:59')
                all_day = true
              end

              if record[12] == '0'
                repeat = false
              elsif record[12] == '1'
                repeat = true
              end

              days = []
              if record[13] == '1'
                days.push('Sunday')
              end
              if record[14] == '1'
                days.push('Monday')
              end
              if record[15] == '1'
                days.push('Tuesday')
              end
              if record[16] == '1'
                days.push('Wednesday')
              end
              if record[17] == '1'
                days.push('Thursday')
              end
              if record[18] == '1'
                days.push('Friday')
              end
              if record[19] == '1'
                days.push('Saturday')
              end

              ## Event Creation
              event = Devx::Event.new(
                calendar_id: @calendar.id,
                name: name,
                description: description,
                tag_list: category,
                location: location,
                contact_name: contact_name,
                private: private_event
              )

              schedule = event.schedules.new(
                start_time: start_time.to_datetime,
                end_time: end_time.to_datetime,
                all_day: all_day,
                repeat: repeat,
                days: days
              )

              ## Original import code
              # name = record[0].to_s.squish
              # start_time = record[1].to_s.squish
              # end_time = record[2].to_s.squish
              # description = record[3].to_s.squish
              # location = record[4].to_s.squish
              # contact_name = record[5].to_s.squish

              # event = Devx::Event.new(
              #   calendar_id: @calendar.id,
              #   name: name,
              #   description: description,
              #   start_time: start_time.to_datetime,
              #   end_time: end_time.to_datetime,
              #   location: location,
              #   contact_name: contact_name
              # )

              if event.valid? && schedule.valid?
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
            return
          end

        end

        if @errors > 0
          redirect_to devx.portal_calendars_path,
          notice: "#{@errors} event(s) could not be imported due to errors"
        else
          redirect_to devx.portal_calendars_path,
          notice: "All events imported successfully"
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


