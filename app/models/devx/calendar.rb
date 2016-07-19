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

    def check_google_calendar
      client = google_cal

      if client.present?
        if self.refresh_token.blank?
          if self.authorization_url.blank?
            self.authorization_url = client.authorize_url
          end

          if self.authorization_code.present?
            self.refresh_token = client.login_with_auth_code(self.authorization_code)
          end
        else
          update_from_google
        end
      end
    end

    def google_cal
      if self.calendar_type == 'Google Calendar'
        client = Google::Calendar.new(
          client_id: self.client_id,
          client_secret: self.client_secret,
          calendar: self.google_calendar_id,
          redirect_url: 'urn:ietf:wg:oauth:2.0:oob',
          refresh_token: self.refresh_token
        )

        return client
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
        return client.events
      end
    end

    def update_from_google
      self.get_all_google_events.try(:each) do |event|
        r = Devx::Event.where(google_event_id: event.id)
        puts r.inspect
        if r.empty?
          e = Devx::Event.new(
            calendar_id: self.id,
            google_event_id: event.id,
            name: event.raw['summary'],
            description: event.description,
            location: event.location
          )

          e.schedules.new(
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
