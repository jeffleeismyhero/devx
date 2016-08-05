module Devx
  class Calendar < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :finders ]

    scope :active, -> { where(active: true) }
    
    has_many :events
    has_many :calendar_subscriptions

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_save :check_google_calendar

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
          client_id: '964786152042-lf6mt3nih4ma5cf55dbg89a6thjcdfe6.apps.googleusercontent.com',
          client_secret: 'PcR-NwdDGwGQXrleQBBMmaaU',
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
        if self.refresh_token.blank?
          if self.authorization_url.blank?
            self.authorization_url = client.authorization_uri.to_s
          end

          if self.authorization_code.present? && self.refresh_token.nil?
            response = client.fetch_access_token!
            self.refresh_token = response['access_token']
          end
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

      if client.present?
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        response = service.list_events(
          calendar_id: 'primary',
          max_results: 50,
          order_by: 'startTime'
        )

        return response
      end
    end

    def update_from_google
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
            name: event.raw['summary'],
            description: event.description,
            location: event.location
          )

          if event.raw['start'].present? && event.raw['start']['date'] =~ /^\d{4}\-\d{2}\-\d{2}$/
            date_only = true
          else
            date_only = false
          end

          e.schedules.new(
            all_day: date_only,
            start_time: event.start_time.to_datetime,
            end_time: event.end_time.to_datetime
          )

          if e.valid?
            e.save
          end
        end
      end

      self.get_google_events.try(:each) do |event|
        r = Devx::Event.where(google_event_id: event.id)
        if r.empty?
          e = Devx::Event.new(
            calendar_id: self.id,
            google_event_id: event.id,
            name: event.raw['summary'],
            description: event.description,
            location: event.location
          )

          if event.raw['start'].present? && event.raw['start']['date'] =~ /^\d{4}\-\d{2}\-\d{2}$/
            date_only = true
          else
            date_only = false
          end

          e.schedules.new(
            all_day: date_only,
            start_time: event.start_time.to_datetime,
            end_time: event.end_time.to_datetime
          )

          if e.valid?
            e.save
          end
        end
      end

    end

  end
end
