require 'rails_helper'

module Devx
  feature 'User signs up', type: 'feature' do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)

    scenario 'with valid e-mail and password' do
      sign_up 'demo@devxcms.com', 'password'
      expect(page).to have_text('You have signed up successfully.')
    end

    scenario 'with invalid e-mail address' do
      sign_up 'demo', 'password'
      expect(page).to have_text('Email is invalid')
    end

    scenario 'with blank password' do
      sign_up 'demo@devxcms.com', ''
      expect(page).to have_text('Password can\'t be blank')
    end
  end
end
