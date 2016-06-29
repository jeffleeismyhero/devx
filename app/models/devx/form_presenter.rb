module Devx
  class FormPresenter
    def self.for
      :form
    end

    def initialize(attributes, content, additional_attributes)
      @attributes = attributes
      @content = content
    end

    def content
      @content
    end

    def attributes
      { form: form,
        fields: fields}
    end


    private

    def form
      Devx::Form.find_by(id: @attributes[:id])
    end

    def fields
      form.fields
    end
  end
end