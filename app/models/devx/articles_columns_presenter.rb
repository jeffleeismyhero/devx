module Devx
  class ArticlesColumnsPresenter
    def self.for
      :articles_columns
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

    def articles
      Devx::Article.published.latest.try(:limit, @attributes[:limit])
    end
  end
end