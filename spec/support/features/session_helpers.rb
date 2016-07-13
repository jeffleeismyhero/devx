module Features
  module SessionHelpers
    def sign_in(user)
      ensure_on devx.portal_dashboard_url(subdomain: 'portal')
      find(:css, '#user_email').set user.email
      find(:css, '#user_password').set user.password
      click_button 'LOGIN'
    end

    def sign_in_with(email, password)
      ensure_on devx.portal_dashboard_url(subdomain: 'portal')
      find(:css, '#user_email').set email
      find(:css, '#user_password').set password
      click_button 'LOGIN'
    end

    def sign_up(email, password)
      ensure_on devx.new_user_registration_url(subdomain: 'portal')
      find(:css, '#user_email').set email
      find(:css, '#user_password').set password
      find(:css, '#user_password_confirmation').set password
      click_link_or_button 'LOGIN'
    end

    def authorize_as_super_administrator(user = create(:devx_user))
      @role = create(:super_administrator_role)
      unless user.roles.include?(@role)
        user.authorizations.create(role: @role)
      end
    end
  end
end