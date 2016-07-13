module Features
  module GeneralHelpers
    def ensure_on(path)
      visit(path) unless current_path == path
    end

    def visit_subdomain
      #Capybara.app_host = "http://portal.#{Capybara.default_host}:#{Capybara.server_port}"
      visit 'http://portal.devxcms.dev:3000'
    end
  end
end