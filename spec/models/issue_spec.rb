require 'spec_helper'

describe Issue do
  let(:user) { FactoryGirl.build(:test_user) }
  let(:issue) { FactoryGirl.create(:issue, number: 1) }

  describe '.github_issue' do
    let(:github_issue) { issue.github_issue(user) }

    before do
      Github::Issue.stub find: FactoryGirl.build(:github_issue)
    end

    it "should return a github issue" do
      github_issue.should be_instance_of(Github::Issue)
    end
  end

  describe '.update_github_issue' do
    it "should update an issue on github" do
      Github::Issue.should_receive(:update).and_return FactoryGirl.build(:github_issue)
      issue.update_github_issue(user)
    end
  end

  describe '.create_github_issue' do
    it "should create an issue on github" do
      Github::Issue.should_receive(:create).and_return FactoryGirl.build(:github_issue)
      issue.create_github_issue(user)
    end
  end

end