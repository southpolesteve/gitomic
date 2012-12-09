require 'spec_helper'

describe 'API Authorization', :type => :api  do
  let(:user) { FactoryGirl.create :user }
  let(:application) { FactoryGirl.create :application }
  let(:url) { '/library.json' }

  context "unsuccessful requests" do
    it "provides no app key" do
      get url
      JSON.parse(last_response.body)['error'].should == 'App token not provided'
    end

    it "provides an incorrect app key" do
      get url, app_token: 'broken'
      JSON.parse(last_response.body)['error'].should == 'Invalid app token'
    end
  end

  context "successful requests" do
    it "does not return an error" do
      FactoryGirl.create :disc, user: user
      get url, app_token: application.token, auth_token: user.authentication_token
      JSON.parse(last_response.body).should_not have_key('error')
    end
  end
end