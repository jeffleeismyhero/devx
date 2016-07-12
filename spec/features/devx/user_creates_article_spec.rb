require 'rails_helper'

module Devx
  feature 'User creates article', type: 'feature' do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)
    
    scenario 'with all fields' do
      skip
      @user = create(:devx_user)
      sign_in @user
      authorize_as_super_administrator @user

      expect(page).to have_content('News')

      within('.cd-side-nav') do
        click_link_or_button('News')
      end
      
      # click_link_or_button('Create Article')

      # fill 'Title'
    end
  end
end