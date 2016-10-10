module Devx
  class SlideshowPresenter
    def self.for
      :slideshow
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { slides: slides }
    end


    private

    def slides
      Devx::Slideshow.find(@attributes[:id]).slides.active
    end
  end
end
