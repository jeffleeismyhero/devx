module Devx
  module ApplicationHelper
    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end



    def full_title(value = '')
      base_title = app_branding.company_name

      if value.present?
        value + ' | ' + base_title
      else
        base_title
      end
    end

    def sc_content(content)
      Shortcode.process(content)
    end

    def sc_content_html(content)
      raw sc_content(content)
    end

    def link_to_add_fields(name, f, association, primary = nil, partial = nil, classes = '')
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        if partial.present?
          render("#{partial}", f: builder, primary: primary)
        else
          render("#{association}/#{association.try(:to_s).try(:singularize)}_fields", f: builder, primary: primary)
        end
      end
      link_to(name, '#', class: "add_fields add-button btn #{classes}", data: {id: id, fields: fields.gsub("\n", "")})
    end
    
  end
end
