module Devx
  class AthleticsPresenter
    def self.for
      :athletics
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { athletics: athletics }
    end


    private

    def athletics
      Devx::Sport.all.order(name: :asc)
    end
  end
end