module Devx
  class MediaPresenter
    def self.for
      :media
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
      @additional_attributes = additional_attributes
    end

    def content
      @content
    end

    def attributes
      { media: media,
        size: @attributes[:size],
        classes: @attributes[:class],
        styles: @attributes[:styles] }
    end


    private

    def media
      Devx::Medium.find(@attributes[:id]).file.url
    end
  end
end