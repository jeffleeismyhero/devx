require 'rails_helper'

module Devx
  feature 'User signs up', type: 'feature' do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)
    
    scenario 'with valid e-mail and password' do
      skip
      sign_up 'demo@devxcms.com', 'password'
      expect(page).to have_content?('Sign up successful')
    end

    scenario 'with invalid e-mail address' do
      skip
      sign_up 'demo', 'password'
      expect(page).to have_content?('Failed to sign up')
    end

    scenario 'with blank password' do
      skip
      sign_up 'demo', ''
      expect(page).to have_content?('Failed to sign up')
    end
  end
end