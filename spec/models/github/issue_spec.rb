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
      issue.labels.should contain_only_instances_of(Github::Label)
    end
  end

  describe '.list_repo' do
    let(:issue) { issues.first }

    it "returns a array of repo issues", :vcr do
      issues.should contain_only_instances_of(Github::Issue)
    end
  end

  describe '.import' do
    let(:imported_issue)
    # let(:imported_user){ imported_user = github_user.import(project.owner, project.name) }

    # context "a user does not exist" do
    #   let(:github_user){ FactoryGirl.build(:github_test_user_2) }

    #   it "should return an new user without a token", :vcr do
    #     imported_user.github_token.should be_nil
    #   end

    #   it "should add the user to the project" do
    #     github_user.import(project.owner, project.name)
    #     project.users.should include(imported_user)
    #   end

    # end

    # context "a user already exists" do
    #   let(:github_user){ FactoryGirl.build(:github_test_user) }

    #   it "should return the existing user", :vcr do
    #     imported_user.should == user
    #   end
    # end

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