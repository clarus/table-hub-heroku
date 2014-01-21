require 'spec_helper'

describe "WebPages pages" do
  subject { page }

  describe "edit page" do
    let (:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit edit_web_page_path(user.web_page)
    end

    it { should have_title("Édition du site") }
    it { should have_content("Édition du site") }
    it { should have_content("Titre") }
    it { should have_button("Sauvegarder les changements") }

    describe "update page" do
      before { click_button "Sauvegarder les changements" }

      it { should have_title("Édition du site") }
      it { should have_content("Édition du site") }
      it { should have_content("Site mis à jour") }
    end

    describe "update page with some changes" do
      before do
        fill_in "Titre", with: "Nouveau titre"
        fill_in "Résumé", with: "Nouveau résumé"
        click_button "Sauvegarder les changements"
      end

      it { should have_title("Édition du site") }
      it { should have_content("Édition du site") }
      it { should have_field("Résumé", with: "Nouveau résumé") }
    end

    describe "update and show the result" do
      before do
        fill_in "Titre", with: "Autre titre"
        click_button "Sauvegarder les changements"
        visit web_page_path(user.web_page)
      end

      it { should have_title("Aperçu") }
      it { should have_content("Autre titre") }
    end
  end

  describe "show page" do
    let (:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit web_page_path(user.web_page)
    end
  end
end