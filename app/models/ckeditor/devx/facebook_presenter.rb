module Devx
  class FacebookPresenter
    def self.for
      :facebook
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { feed: feed,
        limit: @attributes[:limit] }
    end



    private

    def client
      Koala.config.api_version = 'v2.6'
      Koala::Facebook::API.new(token)
    end

    def feed
      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_feeds']
        client.get_connection(Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_uid'], 'posts', { limit: @attributes[:limit], fields: [ 'id', 'message', 'created_time', 'picture', 'link', 'from', 'type' ], type: 'large' })
      else
        return
      end
    end

    def token
      Koala::Facebook::OAuth.new(Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_app_id'], Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_app_secret'], Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_app_callback_url']).get_app_access_token
    end
  end
end