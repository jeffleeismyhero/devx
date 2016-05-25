module Devx
  module ApplicationHelper
    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end

    def breadcrumbs(value)
      current_page = value
      parent = Devx::Page.find(current_page.parent)
      
      if parent.is_home?
        (link_to parent.name, root_path) + ' > ' + current_page.name
      else
        (link_to parent.name, root_path) + ' > ' + current_page.name
      end
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
  end
end
