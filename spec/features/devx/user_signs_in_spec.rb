require 'rails_helper'

module Devx
  feature 'User signs in', type: 'feature' do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)
    
    scenario 'with valid e-mail and password' do
      @user = create(:devx_user)
      sign_in @user
      expect(page).to have_content('Dashboard')
    end

    scenario 'with invalid e-mail address' do
      sign_in_with 'invalid_email', 'password'
      expect(page).to have_selector(:link_or_button, 'LOGIN')
    end

    scenario 'with blank password' do
      sign_in_with 'invalid_email', ''
      expect(page).to have_selector(:link_or_button, 'LOGIN')
    end
  end
end