require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content("Se connecter") }
    it { should have_title("Se connecter") }

    describe "with invalid information" do
      before { click_button "Se connecter" }

      it { should have_title("Se connecter") }
      it { should have_selector('div.alert.alert-danger') }
    
      describe "after visiting another page" do
        before { find('#logo').click }

        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user}

      it { should have_title(user.name) }
      it { should have_link("Édition", href: edit_user_path(user)) }
      it { should have_link("Aperçu", href: user_path(user)) }
      it { should have_link("Paramètres", href: edit_user_path(user)) }
      it { should have_link("Déconnexion", href: signout_path) }
      it { should_not have_link("Se connecter") }

      describe "home page without signup form" do
        before { visit root_path }
        it { should_not have_button("Créer mon compte") }
      end

      describe "followed by signout" do
        before { click_link "Déconnexion" }
        it { should have_link("Se connecter") }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title("Se connecter") }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Mot de passe", with: user.password
          click_button "Se connecter"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
          end
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title("Edit user")) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end