require 'spec_helper'

describe Github::Issue do
  let(:user) { FactoryGirl.build :test_user }
  let(:issues) { Github::Issue.list_repo user, "gitomic-test", "gitomic-test" }

  describe '.new' do
    use_vcr_cassette
    
    let(:issue) { issues.first }

    it "returns an issue with an assignee" do
      issue.assignee.should be_instance_of(Github::User)
    end

    it "returns an issue with a creating user" do
      issue.user.should be_instance_of(Github::User)
    end

    it "returns an issue with labels" do
      issue.labels.should contain_only_instances_of(Github::Label)
    end
  end

  describe '.list_repo' do
    use_vcr_cassette

    let(:project) { FactoryGirl.create :project}
    let(:issue) { issues.first }

    it "returns a array of repo issues" do
      issues.should contain_only_instances_of(Github::Issue)
    end
  end

  describe '#import' do
    use_vcr_cassette

    let(:issue) { FactoryGirl.create(:issue) }
    let(:project) { issue.project }
    let(:imported_issue) { github_issue.import }

    before do
      Github::Issue.any_instance.stub comments: []
    end

    context "when an issue does not exist" do
      let(:github_issue) { FactoryGirl.build(:github_issue, number: issue.number+1 )}

      it "should return a saved issue" do
        imported_issue.should be_instance_of(Issue)
        imported_issue.should be_persisted
      end

      it "should add the issue to the project" do
        project.issues.should include(imported_issue)
      end
    end

    context "an issue already exists" do
      let(:github_issue) { FactoryGirl.build(:github_issue, number: issue.number )}
      it "should return the existing issue" do
        imported_issue.should == issue
      end
    end

  end

  describe '#gitomic_project' do
    let(:issue) { FactoryGirl.build :github_issue }
    let!(:project) { FactoryGirl.create(:project, name: issue.repo_name, owner: issue.owner) }

    it "returns the correct project" do
      issue.gitomic_project.should eq(project)
    end
  end

  describe '#gitomic_issue' do
    let(:issue) { FactoryGirl.create :issue }
    let(:github_issue) { FactoryGirl.build :github_issue, number: issue.number }
    subject{ github_issue.gitomic_issue }

    it{ should eq(issue) }
  end

  describe '.create' do
    use_vcr_cassette

    let(:project) { FactoryGirl.build :project }
    subject{ Github::Issue.create project.creator, project.owner, project.name, title: 'Test', body: 'test' }

    it { should be_instance_of(Github::Issue) }
  end

  describe '.update' do
    use_vcr_cassette

    let(:issue) { FactoryGirl.build :issue }
    subject{ Github::Issue.update issue.project.creator, issue.project_owner, issue.project_name, 1, title: 'Test', body: 'changed' }

    it { should be_instance_of(Github::Issue) }
  end

  describe '.find' do
    use_vcr_cassette

    let(:issue) { FactoryGirl.build :issue }
    subject{ Github::Issue.find issue.project.creator, issue.project_owner, issue.project_name, 1 }

    it { should be_instance_of(Github::Issue) }
  end
end