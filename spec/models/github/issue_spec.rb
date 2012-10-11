require 'spec_helper'

describe Github::Issue do
  let(:user) { FactoryGirl.build :test_user }
  let(:issues) { Github::Issue.list_repo user, "gitomic-test", "gitomic-test" }

  describe '.new' do
    let(:issue) { issues.first }

    it "returns an issue with an assignee", :vcr do
      issue.assignee.should be_instance_of(Github::User)
    end

    it "returns an issue with a creating user", :vcr do
      issue.user.should be_instance_of(Github::User)
    end

    it "returns an issue with labels", :vcr do
      issue.labels.map(&:class).uniq.first.should == Github::Label
    end
  end

  describe '.list_repo' do
    let(:issue) { issues.first }

    it "returns a array of repo issues", :vcr do
      issues.should have_at_least(1).items
      issue.should be_instance_of(Github::Issue)
    end
  end

  describe '.gitomic_project' do
    let(:issue) { FactoryGirl.build :github_issue }
    let!(:project) { FactoryGirl.create(:project, name: issue.repo_name, owner: issue.owner) }

    it "returns the correct project" do
      issue.gitomic_project.should eq(project)
    end
  end

  # TODO
  # describe '.gitomic_issue'
  
end