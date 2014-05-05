def sign_in(user)
  visit new_user_session_path
  fill_in "user_email", with: user.email
  fill_in "user_password", with: user.password
  click_button 'Sign In'
end

def sign_out
  Capybara.current_session.driver.delete destroy_user_session_path, method: :delete
end

def sign_up(email, password, password_confirmation)
  visit new_user_registration_path
  fill_in 'user_email', with:  email
  fill_in 'user_password', with:  password
  fill_in 'user_password_confirmation', with:  password_confirmation
  click_button 'Sign Up'
end