module Devx
  class LatestArticlesPresenter
    def self.for
      :latest_articles
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { articles: articles,
        limit: @attributes[:limit] }
    end


    private

    def media
      Devx::Article.latest.try(:limit, @attributes[:limit])
    end
  end
end