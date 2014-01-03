require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { should have_content("Sign Up") }
    it { should have_title(full_title("Sign Up")) }

    describe "with invalid information" do
      it "should not create an user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after empty submission" do
        before { click_button submit }

        it { should have_title("Sign Up") }
        it { should have_content("error") }
      end

      describe "after submission with wrong email" do
        before do
          fill_in "Name", with: "Guillaume Claret"
          fill_in "Email", with: "guillaume@email"
          fill_in "Password", with: "secret"
          fill_in "Confirmation", with: "secret"
          click_button submit
        end

        it { should have_title("Sign Up") }
        it { should have_content("1 error") }
        it { should have_content("Email is invalid") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Guillaume Claret"
        fill_in "Email", with: "guillaume@email.com"
        fill_in "Password", with: "secret"
        fill_in "Confirmation", with: "secret"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by email: "guillaume@email.com" }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: "Welcome") }
      end
    end
  end

  describe "show page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
end