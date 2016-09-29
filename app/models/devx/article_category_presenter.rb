module Devx
  class ArticleCategoryPresenter
    def self.for
      :article_category
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
      Devx::Article.try(:tagged_with, @attributes[:category]).published.latest.try(:limit, @attributes[:limit])
    end
  end
end