require 'rails_helper'

module Devx
  Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)

  feature 'User creates article', type: 'feature' do
    before(:each) do
      @user = create(:devx_user)
      @article = build(:devx_article)
      @tag = ActsAsTaggableOn::Tag.create(name: 'Test Category')
    end

    scenario 'with all required fields', js: true do
      sign_in @user
      authorize_as_super_administrator @user

      ensure_on devx.new_portal_article_path
      expect(page).to have_content('Create Article')

      within('form.new_article') do
        find(:css, '#article_title').set @article.title
        page.execute_script("$('#article_tag_list').empty().append('<option value=\"#{@tag.name}\">#{@tag.name}</option>').val('#{@tag.name}').trigger('change');")

        find(:css, '#article_published_at_date').set '11/16/2016'
        page.execute_script("$('.datepicker').datetimepicker('hide')")
        find(:css, '#article_published_at_time').set '9:30 pm'
        page.execute_script("$('.timepicker').timepicker('hide')")

        page.execute_script("CKEDITOR.instances['article_content'].setData('Test article content')")

        click_link_or_button('Create Article')
      end

      expect(page).to have_content('Successfully created article')

      click_link_or_button(@article.title)

      expect(find(:css, '#article_title').value).to eq(@article.title)
      expect(find(:css, '#article_published_at_date').value).to eq('11/16/2016')
      expect(find(:css, '#article_published_at_time').value).to eq('9:30 pm')
    end
  end
end
