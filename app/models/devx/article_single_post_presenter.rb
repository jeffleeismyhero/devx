module Devx
  class ArticleSinglePostPresenter
    def self.for
      :article_single_post
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { article: article }
    end


    private

    def article
      Devx::Article.try(:tagged_with, @attributes[:category]).published.latest.first
    end
  end
end