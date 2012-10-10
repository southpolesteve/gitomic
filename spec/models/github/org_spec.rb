require 'spec_helper'

describe Github::Org do
  let(:user) { FactoryGirl.build :test_user }

  describe '.all' do
    it "should return all organizations", :vcr do
      orgs = Github::Org.all user
      orgs.size.should_not == 0
      orgs.first.should be_instance_of(Github::Org)
    end
  end

  describe '.members' do
    it "should return org members", :vcr do
      members = Github::Org.members user, "gitomic-test-organization"
      members.size.should_not == 0
      members.first.should be_instance_of(Github::User)
    end
  end

end