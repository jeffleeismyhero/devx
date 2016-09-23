module Devx
  class Calendar < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    scope :active, -> { where(active: true) }

    has_many :events
    has_many :schedules, through: :events
    has_many :calendar_subscriptions

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    #before_save :update_from_google
    before_save :connect_to_google

    def google_calendar
      if self.calendar_type == 'Google Calendar'
        return @client = Devx::GoogleCalendar.new({
            client_id: self.client_id,
            client_secret: self.client_secret
          })
      else
        return nil
      end
    end

    def connect_to_google
      connection = google_calendar

      if connection.present?
        if !self.refresh_token.present?
          if !self.authorization_code.present?
            self.authorization_url = connection.authorization_url
          else
            connection.client.code = self.authorization_code
            Devx::GoogleCalendar.get_access_token(connection.client)
            self.refresh_token = connection.refresh_token
          end
        else
          connection.login(self.refresh_token)
          Devx::Calendar.where(calendar_type: 'Google Calendar').try(:each) do |calendar|
            calendar.delay.synchronize(connection.client)
          end
        end
      end
    rescue Signet::AuthorizationError
      self.update_columns(authorization_code: nil, refresh_token: nil)
    end


    def get_all_google_events(client)
      if client.present?
        calendar_id = self.google_calendar_id
        service = Google::Apis::CalendarV3::CalendarService.new
        service.client_options.application_name = 'DevX'
        service.authorization = client
        response = service.list_events(
          calendar_id,
          max_results: 2500,
          single_events: true,
          order_by: 'startTime',
          time_min: Time.now.beginning_of_year.iso8601,
          time_max: (Time.now + 1.year).iso8601
        )

        return response.items
      end
    end

    def synchronize(client)
      self.events.destroy_all if self.events.any?

      self.get_all_google_events(client).try(:each) do |event|
        existing = Devx::Event.where("calendar_id = ? AND google_event_id LIKE '#{event.id.try(:split, '_').try(:first)}%'", self.id).try(:first)

        if existing.nil?
          e = Devx::Event.new(
            calendar_id: self.id,
            google_event_id: event.id,
            name: event.summary,
            description: event.description,
            location: event.location
          )

          if event.start.try(:date).present?
            date_only = true
            start_time = event.start.date.in_time_zone.beginning_of_day

            if event.end.date.to_date.to_s == (event.start.date.to_date + 1.day).to_s
              end_time = event.start.date.in_time_zone.end_of_day
            else
              end_time = event.end.date.in_time_zone.end_of_day - 1.day
            end
          elsif event.start.try(:date_time).present?
            date_only = false
            start_time = event.start.date_time.in_time_zone
            end_time = event.end.date_time.in_time_zone
          end

          e.schedules.new(
            all_day: date_only,
            start_time: start_time,
            end_time: end_time
          )

          e.save if e.valid?
        else
          if event.start.try(:date).present?
            date_only = true
            start_time = event.start.date.in_time_zone.beginning_of_day

            if event.end.date.to_date.to_s == (event.start.date.to_date + 1.day).to_s
              end_time = event.start.date.in_time_zone.end_of_day
            else
              end_time = event.end.date.in_time_zone.end_of_day - 1.day
            end
          elsif event.start.try(:date_time).present?
            date_only = false
            start_time = event.start.date_time.in_time_zone
            end_time = event.end.date_time.in_time_zone
          end

          existing.schedules.new(
            all_day: date_only,
            start_time: start_time,
            end_time: end_time
          )

          existing.save if existing.valid?
        end
      end
    end

  end
end
