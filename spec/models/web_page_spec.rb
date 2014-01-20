require 'spec_helper'

describe WebPage do
  let (:user) { FactoryGirl.create(:user) }
  before do
    @web_page = user.build_web_page(
      title: "My restaurant",
      summary: "The best restaurant ever is now opening!")
  end
  subject { @web_page }

  it { should respond_to(:title) }
  it { should respond_to(:summary) }
  it { should respond_to(:user) }
  its (:user) { should eq user }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @web_page.user_id = nil }
    it { should_not be_valid }
  end
end
