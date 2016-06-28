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
        photo: get_photo(feed.first['id']),
        like_count: like_count(feed.first['id']),
        limit: @attributes[:limit] }
    end



    private

    def client
      Koala.config.api_version = 'v2.6'
      Koala::Facebook::API.new(token)
    end

    def feed
      client.get_connection(Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_uid'], 'posts', { limit: 1, fields: [ 'id', 'message', 'created_time', 'picture', 'link', 'from', 'type' ], type: 'large' })
    end

    def get_photo(post_id)
      connection = client.get_connection(post_id, 'attachments').first['subattachments']
      
      if connection.nil?
        return false
      else
        return client.try(:get_connection, post_id, 'attachments').first['subattachments']['data'].first['media']['image']
      end
    end

    def like_count(post_id)

      client.get_object(post_id, :fields => "likes.summary(true)")["likes"]["summary"]["total_count"]
    end

    def token
      Koala::Facebook::OAuth.new(Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_app_id'], Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_app_secret'], Devx::ApplicationSetting.find_or_create_by(id: 1).settings['facebook_app_callback_url']).get_app_access_token
    end
  end
end