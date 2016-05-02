module Devx
  module ApplicationHelper
    def app_branding
      Devx::Branding.find_or_create_by(id: 1)
    end
  end
end
