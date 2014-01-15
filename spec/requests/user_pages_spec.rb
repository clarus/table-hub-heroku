require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Créer mon compte" }

    it { should have_content("Inscription") }
    it { should have_title(full_title("Inscription")) }
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

  describe "show page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "edit page" do
    let (:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_title("Préférences") }
      it { should have_content("Préférences") }
      it { should have_link("modifier", href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Sauvegarder changements" }

      it { should have_content "erreur" }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nom", with: new_name
        fill_in "Email", with: new_email
        fill_in "Mot de passe", with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Sauvegarder"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link("Déconnexion", href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end