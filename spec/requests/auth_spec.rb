require 'spec_helper'

describe "authorization" do

  context 'a new user auths' do
    before{ login }
    it "redirects me to the projects page" do
      current_url.should == projects_url
    end

    it "creates a new user with a token" do
      user = User.where(github_login: "gitomic-test").first
      user.should_not be_nil
      user.github_token.should_not be_nil
    end
  end

  context 'a new user auths who has already been imported via a project' do
    before do
      User.create(github_login: 'gitomic-test')
      login
    end

    it "does not create a new user record" do
      User.count.should == 1
    end

    it "updates authorization for existing imported user" do
      user = User.where(github_login: "gitomic-test").first
      user.github_token.should_not be_nil
    end  
  end

end