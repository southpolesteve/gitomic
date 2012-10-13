require 'spec_helper'

describe "authorization" do
  before do
    visit root_path
    click_on "Login"
  end

  it "redirects me to the projects page" do
    current_url.should == projects_url
  end

  it "creates a new user with a token" do
    user = User.where(github_login: "gitomic-test").first
    user.should_not be_nil
    user.github_token.should_not be_nil
  end
  

end