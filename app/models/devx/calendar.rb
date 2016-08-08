module Devx
  class Calendar < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    scope :active, -> { where(active: true) }

    has_many :events
    has_many :calendar_subscriptions

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_save :update_from_google

    def upcoming_events
      self.events.where("start_time > ?", Time.zone.now).order(start_time: :asc)
    end

    def google_cal
      if self.calendar_type == 'Google Calendar'
        # client = Google::Calendar.new(
        #   client_id: self.client_id,
        #   client_secret: self.client_secret,
        #   calendar: self.google_calendar_id,
        #   redirect_url: 'urn:ietf:wg:oauth:2.0:oob',
        #   refresh_token: self.refresh_token
        # )

        code = self.authorization_code unless self.refresh_token.present?

        client = Signet::OAuth2::Client.new({
          client_id: self.client_id,
          client_secret: self.client_secret,
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
          authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
          redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
          scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
          grant_type: 'refresh_token',
          code: code,
          refresh_token: self.refresh_token
        })

        return client
      end
    end

    def check_google_calendar
      client = google_cal
      if client.present?
        if !self.refresh_token.present?
          if !self.authorization_url.present?
            self.authorization_url = client.authorization_uri.to_s
          end
        end

        if self.authorization_code.present?
          response = client.fetch_access_token!
          self.refresh_token = response['access_token']
        end
      end
    end

    def get_google_events
      client = google_cal

      if client.present?
        return client.find_future_events
      end
    end

    def get_all_google_events
      client = google_cal
      check_google_calendar

      if client.present?
        calendar_id = self.google_calendar_id
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        response = service.list_events(
          calendar_id,
          max_results: 2500,
          single_events: true,
          order_by: 'startTime',
          time_min: Time.now.iso8601,
          time_max: (Time.now + 2.year).iso8601
        )

        return response.items
      end
    end

    def update_from_google
      if !self.refresh_token.present?
        check_google_calendar
        return
      end

      if self.events.any?
        self.events.try(:each) do |e|
          e.destroy
        end
      end

      self.get_all_google_events.try(:each) do |event|
        r = Devx::Event.where(google_event_id: event.id)
        if r.empty?
          e = Devx::Event.new(
            calendar_id: self.id,
            google_event_id: event.id,
            name: event.summary,
            description: event.description,
            location: event.location
          )

          if event.start.try(:date).present?
            date_only = true
            start_time = event.start.date.to_datetime.beginning_of_day

            if event.end.date.to_datetime == (event.start.date.to_datetime + 1.day)
              end_time = event.start.date.to_datetime.end_of_day
            else
              end_time = event.end.date.to_datetime.end_of_day - 1.day
            end
          elsif event.start.try(:date_time).present?
            date_only = false
            start_time = event.start.date_time.to_datetime
            end_time = event.end.date_time.to_datetime
          end

          e.schedules.new(
            all_day: date_only,
            start_time: start_time,
            end_time: end_time
          )

          if e.valid?
            e.save
          end
        end
      end

    end

  end
end
