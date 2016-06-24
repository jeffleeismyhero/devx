module Features
  module SessionHelpers
    def sign_in
      user = FactoryGirl.create(:devx_user)
      ensure_on devx.portal_dashboard_path
      find(:css, '#user_email').set user.email
      find(:css, '#user_password').set user.password
      click_link_or_button 'Login'
    end

    def sign_up(email, password)
      ensure_on devx.new_user_registration_path
      find(:css, '#user_email').set email
      find(:css, '#user_password').set password
      find(:css, '#user_password_confirmation').set password
      click_link_or_button 'Log in'
    end
  end
end