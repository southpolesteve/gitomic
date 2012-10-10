require 'spec_helper'

describe Github::Repo do
  let(:user) { FactoryGirl.build :test_user }

  describe '.all' do
    it "should return all user repos", :vcr do
      repos = Github::Repo.all user
      repos.size.should_not == 0
      repos.first.should be_instance_of(Github::Repo)
    end
  end

  describe '.collaborators' do
    it "should return all repo collaborators", :vcr do
      collaborators = Github::Repo.collaborators user, "gitomic-test", "gitomic-test"
      collaborators.size.should_not == 0
      collaborators.first.should be_instance_of(Github::User)
    end
  end

end