require 'rails_helper'

module Devx
  feature 'User creates event', type: 'feature' do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)

    before(:each) do
      @user = create(:devx_user)
      @calendar = create(:devx_calendar)
      @event = build(:devx_event)
    end

    scenario 'with all required fields', js: true do
      sign_in @user
      authorize_as_super_administrator @user
      ensure_on devx.new_portal_calendar_event_path(@calendar)
      expect(page).to have_content('Create Event')

      within('form.new_event') do
        find(:css, '#event_name').set @event.name

        click_link_or_button('Add Schedule')

        find(:css, '.start-time-date').set '11/16/2016'
        page.execute_script("$('.datepicker').datetimepicker('hide')")
        find(:css, '.start-time-time').set '9:30 PM'
        page.execute_script("$('.timepicker').timepicker('hide')")
        find(:css, '.end-time-date').set '11/16/2016'
        page.execute_script("$('.datepicker').datetimepicker('hide')")
        find(:css, '.end-time-time').set '10:30 PM'
        page.execute_script("$('.timepicker').timepicker('hide')")

        click_link_or_button('Create Event')
      end

      expect(page).to have_content('Successfully created event')
      expect(page).to have_selector("input#event_name[value='#{@event.name}']")
    end
  end
end
