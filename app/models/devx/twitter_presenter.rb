module Devx
  class TwitterPresenter
    def self.for
      :twitter
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { tweets: tweets,
        limit: @attributes[:limit] }
    end


    private

    def client
      Twitter::REST::Client.new do |config|
        config.consumer_key = Devx::ApplicationSetting.find(1).settings['twitter_consumer_key']
        config.consumer_secret = Devx::ApplicationSetting.find(1).settings['twitter_consumer_secret']
        config.access_token = Devx::ApplicationSetting.find(1).settings['twitter_access_token']
        config.access_token_secret = Devx::ApplicationSetting.find(1).settings['twitter_access_token_secret']
      end
    end

    def tweets
      if Devx::ApplicationSetting.find_or_create_by(id: 1).settings['twitter_feeds']
        client.user_timeline(Devx::ApplicationSetting.find_or_create_by(id: 1).settings['twitter_timeline'], { include_rts: @attributes[:retweet], count: @attributes[:limit] }) rescue nil
      else
        return
      end
    end
  end
end
