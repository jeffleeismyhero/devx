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
      { extracurriculars: extracurriculars }
    end


    private

    def extracurriculars
      Devx::Extracurricular.all.order(name: :asc)
    end
  end
end