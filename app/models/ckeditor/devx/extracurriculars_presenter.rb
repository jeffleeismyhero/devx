module Devx
  class ExtracurricularsPresenter
    def self.for
      :extracurriculars
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { extracurriculars: extracurriculars,
        group: @attributes[:group],
        style: @attributes[:style],
        limit: @attributes[:limit]
      }
    end


    private

    def extracurriculars
      Devx::Extracurricular.ordered.try(:limit, @attributes[:limit])
    end
  end
end
