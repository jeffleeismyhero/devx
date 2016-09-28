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
        category: @attributes[:category],
        limit: @attributes[:limit] }
    end


    private

    def articles
      Devx::Article.try(:tagged_with, @attributes[:category]).published.latest.try(:limit, @attributes[:limit])
    end
  end
end