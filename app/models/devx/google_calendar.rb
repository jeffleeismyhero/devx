module Devx
  class GoogleCalendar
    AUTHORIZATION_URI = 'https://accounts.google.com/o/oauth2/auth'
    TOKEN_URI = 'https://accounts.google.com/o/oauth2/token'
    SCOPE = 'https://www.googleapis.com/auth/calendar'

    def initialize(params, client = nil)

      raise ArgumentError unless client || Devx::GoogleCalendar.check_credentials?(params)

      @client ||= Signet::OAuth2::Client.new(
        authorization_uri: AUTHORIZATION_URI,
        token_credential_uri: TOKEN_URI,
        scope: SCOPE,
        grant_type: 'refresh_token',
        client_id: params[:client_id],            #'796581802106-ja9allaj0mjelh1u4c5o79f5kmu2p43k.apps.googleusercontent.com',
        client_secret: params[:client_secret],    #'NRPfV05cP57-Q05w-KcTB9ey',
        redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
        refresh_token: params[:refresh_token],
        state: params[:state]
      )
    end

    def client
      @client
    end

    def authorization_url
      @client.authorization_uri.to_s
    end

    def authorization_code
      @client.code
    end

    def access_token
      @client.access_token
    end

    def refresh_token
      @client.refresh_token
    end

    def login(refresh_token)
      @client.refresh_token = refresh_token
      @client.grant_type = 'refresh_token'
      Devx::GoogleCalendar.get_access_token(@client)
    end


    protected

    def self.get_access_token(client)
      begin
        client.fetch_access_token!
      end
    end

    def self.check_credentials?(params)
      (params[:client_id].present?) && (params[:client_secret].present?)
    end
  end
end
