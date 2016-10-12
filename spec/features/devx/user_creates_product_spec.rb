require 'rails_helper'

module Devx
  Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)

  feature 'User creates product', type: 'feature' do
    before(:each) do
      @user = create(:devx_user)
      @product = build(:devx_product)
    end

    scenario 'with all required fields', js: true do
      sign_in @user
      authorize_as_super_administrator @user

      ensure_on devx.new_portal_product_path
      expect(page).to have_content('Create Products')

      within('form.new_product') do
        find(:css, '#product_name').set @product.name

        page.execute_script("CKEDITOR.instances['product_description'].setData('Test product content')")

        click_link_or_button('Create Product')
      end

      expect(page).to have_content('Successfully saved product')
      expect(find(:css, '#product_name').value).to eq(@product.name)
    end

    scenario 'with a sku', js: true do
      sign_in @user
      authorize_as_super_administrator @user

      ensure_on devx.new_portal_product_path
      expect(page).to have_content('Create Products')

      within('form.new_product') do
        find(:css, '#product_name').set @product.name

        page.execute_script("CKEDITOR.instances['product_description'].setData('Test product content')")

        click_link_or_button('Create Product')
      end

      expect(page).to have_content('Successfully saved product')
      expect(find(:css, '#product_name').value).to eq(@product.name)

      click_link_or_button 'Back to Products'

      click_link_or_button 'Manage SKUs'
    end
  end
end
