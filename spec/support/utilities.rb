include ApplicationHelper

def sign_in(user, no_capybara: false)
  if no_capybara
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Mot de passe", with: user.password
    click_button "Se connecter"
  end
end