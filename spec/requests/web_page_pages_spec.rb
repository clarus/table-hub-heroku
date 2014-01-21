require 'spec_helper'

describe "WebPages pages" do
  subject { page }

  describe "edit page" do
    let (:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit edit_web_page_path(user.web_page)
    end

    it { should have_content("Édition du site") }
  end

  describe "show page" do
    let (:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit web_page_path(user.web_page)
    end
  end
end