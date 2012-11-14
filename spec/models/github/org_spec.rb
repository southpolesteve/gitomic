require 'spec_helper'

describe Github::Org do
  let(:user) { FactoryGirl.build :test_user }

  describe '.all' do
    use_vcr_cassette

    it "should return all organizations" do
      orgs = Github::Org.all user
      orgs.should contain_only_instances_of(Github::Org)
    end
  end

  describe '.members' do
    use_vcr_cassette

    it "should return org members" do
      members = Github::Org.members user, "gitomic-test-organization"
      members.should contain_only_instances_of(Github::User)
    end
  end

  describe '.repos' do
    use_vcr_cassette

    let(:github_org) { FactoryGirl.build :github_org }
    it "should return org repos" do
      repos = github_org.repos(user)
      repos.should contain_only_instances_of(Github::Repo)
    end
  end

end