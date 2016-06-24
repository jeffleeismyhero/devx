require 'rails_helper'

module Devx
  feature 'User signs up', type: 'feature' do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)
    
    scenario 'with valid e-mail and password' do
      skip
      sign_up 'demo@devxcms.com', 'password'
      assert page.has_content?('Sign up successful'), 'Failed to sign up'
    end

    scenario 'with invalid e-mail address' do
      skip
      sign_up 'demo', 'password'
      assert page.has_content?('Failed to sign up'), 'No error message shown'
    end

    scenario 'with blank password' do
      skip
      sign_up 'demo', ''
      assert page.has_content?('Failed to sign up'), 'No error message shown'
    end
  end
end