require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content("Sign In") }
    it { should have_title("Sign In") }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title("Sign In") }
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
      it { should have_link("Profile", href: user_path(user)) }
      it { should have_link("Settings", href: edit_user_path(user)) }
      it { should have_link("Sign out", href: signout_path) }
      it { should_not have_link("Sign in") }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title("Sign In") }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end