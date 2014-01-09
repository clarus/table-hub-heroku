require 'spec_helper'

describe "Static pages" do
  base_title = "Table-Hub"
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content("Table-Hub") }
    it { should have_title(full_title("")) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content("Contact") }
    it { should have_title(full_title("Contact")) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content("À propos") }
    it { should have_title(full_title("À propos")) }
  end
end