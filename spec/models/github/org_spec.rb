require 'spec_helper'

describe Github::Org do
  let(:user) { FactoryGirl.build :test_user }

  describe '.all' do
    it "should return all organizations", :vcr do
      orgs = Github::Org.all user
      orgs.should contain_only_instances_of(Github::Org)
    end
  end

  describe '.members' do
    it "should return org members", :vcr do
      members = Github::Org.members user, "gitomic-test-organization"
      members.should contain_only_instances_of(Github::User)
    end
  end

  describe '.repos' do
    let(:github_org) { FactoryGirl.build :github_org }
    it "should return org repos", :vcr do
      repos = github_org.repos(user)
      repos.should contain_only_instances_of(Github::Repo)
    end
  end

end