require 'spec_helper'

describe Issue do
  let(:user) { FactoryGirl.build(:test_user) }

  describe '#find_github_issue' do
    let(:github_issue) { issue.find_github_issue(user) }
    let(:issue) { FactoryGirl.build(:issue, number: 1) }

    before do
      Github::Issue.stub find: FactoryGirl.build(:github_issue)
    end

    it "should return a github issue" do
      github_issue.should be_instance_of(Github::Issue)
    end
  end

  describe '#update_github_issue' do
    let(:issue) { FactoryGirl.build(:issue, number: 1) }

    it "should update an issue on github" do
      Github::Issue.should_receive(:update).and_return FactoryGirl.build(:github_issue)
      issue.update_github_issue(user)
    end
  end

  describe '#create_github_issue' do
    let(:issue) { FactoryGirl.build(:issue, number: nil) }

    before do
      Github::Issue.should_receive(:create).and_return FactoryGirl.build(:github_issue)
      issue.create_github_issue(user)
    end

    subject{ issue }

    it { should be_persisted }
    its(:number){ should_not be_nil }
    its(:github_created_at){ should_not be_nil }
  end

end