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

def check_signup
  let(:submit) { "Créer mon compte" }

  it { should_not have_content("Nom") }

  describe "with invalid information" do
    it "should not create an user" do
      expect { click_button submit }.not_to change(User, :count)
    end

    describe "after empty submission" do
      before { click_button submit }

      it { should have_title("Inscription") }
      it { should have_content("erreur") }
    end

    describe "after submission with wrong email" do
      before do
        fill_in "Email", with: "guillaume@email"
        fill_in "Mot de passe", with: "secret"
        fill_in "Confirmation", with: "secret"
        click_button submit
      end

      it { should have_title("Inscription") }
      it { should have_content("1 erreur") }
      it { should have_content("Email n'est pas valide") }
    end
  end

  describe "with valid information" do
    before do
      fill_in "Email", with: "guillaume@email.com"
      fill_in "Mot de passe", with: "secret"
      fill_in "Confirmation", with: "secret"
    end

    it "should create a user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end

    describe "after saving the user" do
      before { click_button submit }
      let(:user) { User.find_by email: "guillaume@email.com" }

      it { should have_title(user.name) }
      it { should have_selector('div.alert.alert-success', text: "Bienvenue") }
      it { should have_link("Déconnexion", href: signout_path) }
    end
  end
end