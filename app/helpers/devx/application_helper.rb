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
  end
end
