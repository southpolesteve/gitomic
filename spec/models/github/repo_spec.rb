require 'spec_helper'

describe Github::Repo do
  let(:user) { FactoryGirl.build :test_user }

  describe '.all' do
    it "should return all user repos", :vcr do
      repos = Github::Repo.all user
      repos.should contain_only_instances_of(Github::Repo)
    end
  end

  describe '.collaborators' do
    it "should return all repo collaborators", :vcr do
      collaborators = Github::Repo.collaborators user, "gitomic-test", "gitomic-test"
      collaborators.should contain_only_instances_of(Github::User)
    end
  end

end