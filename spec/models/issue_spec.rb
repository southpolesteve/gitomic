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

end