module Devx
  module ApplicationHelper
    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end

    def app_settings
      Devx::ApplicationSetting.find_or_create_by(id:1).settings
    end


    def full_title(value = '')
      base_title = app_branding.company_name.to_s

      if value.present?
        value + ' | ' + base_title
      else
        base_title
      end
    end

    def sys_title(value = '')
      base_title = app_branding.site_name.to_s

      if value.present?
        value + ' | ' + base_title
      else
        base_title
      end
    end

    def meta_title(page)
      if page.meta_title.present?
        if page.is_home == true
          page.meta_title
        else
          page.meta_title + ' | ' + app_branding.company_name.to_s
        end
      else
        page.name + ' | ' + app_branding.company_name.to_s
      end
    end

    def ldate(date)
      date.try(:strftime, '%b %d, %Y - %I:%M %p ')
    end

    def google_date(date)
      date.try(:strftime, '%b %d, %Y - %I:%M %p ')
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

    def us_states
      ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'District of Columbia','Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Puerto Rico', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming']
    end

    def date_value(value=nil)
      if value.respond_to?(:strftime)
        value.strftime("%m/%d/%Y")
      else
        value
      end
    end

    def time_value(value=nil)
      if value.respond_to?(:strftime)
        value.strftime("%l:%M %P")
      else
        value
      end
    end

    def alert_message(messages)
      if messages.any?
        content_tag :div, class: 'container banner secondary hide-for-medium-down' do
          content_tag :div, class: 'row' do
            content_tag :div, class: 'large-12 columns' do
              messages.collect do |message|
                content_tag :div, class: 'message' do
                  concat content_tag :h2, message.title, class: 'alert-title'
                  concat content_tag :p, message.message, class: 'alert-message'
                end
              end.reduce(:<<)
            end
          end
        end
      end
    end
  end
end
