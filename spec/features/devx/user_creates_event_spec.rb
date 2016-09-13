require 'rails_helper'

module Devx
  Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)

  feature 'User creates event', type: 'feature' do
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
        find(:css, '.start-time-time').set '9:30 pm'
        page.execute_script("$('.timepicker').timepicker('hide')")
        find(:css, '.end-time-date').set '11/16/2016'
        page.execute_script("$('.datepicker').datetimepicker('hide')")
        find(:css, '.end-time-time').set '10:30 pm'
        page.execute_script("$('.timepicker').timepicker('hide')")

        click_link_or_button('Create Event')
      end

      expect(page).to have_content('Successfully created event')
      expect(page).to have_selector("input#event_name[value='#{@event.name}']")
      expect(find(:css, '.start-time-date').value).to eq('11/16/2016')
      expect(find(:css, '.start-time-time').value).to eq('9:30 pm')
      expect(find(:css, '.end-time-date').value).to eq('11/16/2016')
      expect(find(:css, '.end-time-time').value).to eq('10:30 pm')
    end

    scenario 'with a schedule during daylight savings time', js: true do
      sign_in @user
      authorize_as_super_administrator @user
      ensure_on devx.new_portal_calendar_event_path(@calendar)
      expect(page).to have_content('Create Event')

      within('form.new_event') do
        find(:css, '#event_name').set @event.name

        click_link_or_button('Add Schedule')

        find(:css, '.start-time-date').set '09/15/2016'
        page.execute_script("$('.datepicker').datetimepicker('hide')")
        find(:css, '.start-time-time').set '12:00 pm'
        page.execute_script("$('.timepicker').timepicker('hide')")
        find(:css, '.end-time-date').set '09/15/2016'
        page.execute_script("$('.datepicker').datetimepicker('hide')")
        find(:css, '.end-time-time').set '3:47 pm'
        page.execute_script("$('.timepicker').timepicker('hide')")

        click_link_or_button('Create Event')
      end

      expect(page).to have_content('Successfully created event')
      expect(page).to have_selector("input#event_name[value='#{@event.name}']")
      expect(find(:css, '.start-time-date').value).to eq('09/15/2016')
      expect(find(:css, '.start-time-time').value).to eq('12:00 pm')
      expect(find(:css, '.end-time-date').value).to eq('09/15/2016')
      expect(find(:css, '.end-time-time').value).to eq('3:47 pm')
    end
  end
end
