module Devx
  class FaqsPresenter
    def self.for
      :faqs
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { faqs: faqs }
    end


    private

    def faqs
      Devx::Faq.all.order(question: :asc)
    end
  end
end