require 'spec_helper'

describe Project do
  let(:user){ FactoryGirl.create(:test_user) }
  let(:project){ FactoryGirl.create(:project, creator: user) }

  describe '#import_labels' do
    before do
      Github::Label.stub list: [ FactoryGirl.build(:github_label) ]
      project.import_labels
    end

    it "should import and save all repo labels" do
      project.labels.should have_at_least(1).items
      project.labels.should all_be_persisted
    end

    it "should update the labels imported time" do
      project.labels_imported_at.should_not be_nil
    end
  end

  describe '#import_team' do
    before do
      Github::Repo.stub collaborators: [ FactoryGirl.build(:github_test_user), FactoryGirl.build(:github_test_user_2) ]
      project.import_team
    end

    context 'for a user repo' do
      it "should import collaborators" do
        project.users.should have_at_least(2).items
        project.users.should all_be_persisted
      end
    end

    context 'for a org repo' do
      let(:project){ FactoryGirl.create(:org_project, creator: user)}

      it "should import org members" do
        project.users.should have_at_least(2).items
        project.users.should all_be_persisted
      end
    end
  end

  describe '#import_issues' do
    before do
      Github::Issue.stub list_repo: [ FactoryGirl.build(:github_issue) ]
      Github::Issue.any_instance.stub comments: []
      project.import_issues
    end

    it "should import and save all repo issues", :vcr do
      project.issues.should have_at_least(1).items
      project.issues.should all_be_persisted
    end

    it "should update the issues imported time", :vcr do
      project.issues_imported_at.should_not be_nil
    end
  end

  describe '#import_github' do
    let(:user) { FactoryGirl.create(:test_user) }
    let(:project) { FactoryGirl.create(:project, creator: user, owner: "rails", name: "rails" )}
    let(:github_client) { user.github }
    let(:collaborator_count) { github_client.repos.collaborators.list("rails","rails").count }
    let(:open_issues_count) { github_client.repos.get("rails", "rails").open_issues_count }
    let(:labels_count) { github_client.issues.labels.list("rails","rails").count }


    # This test is extremely slow (2 minutes long, 300 open issues, 25 collabs) but it passes
    # it "should import a large project", :vcr do
    #   project.import_github
    #   project.users.count.should == collaborator_count
    #   project.issues.count.should == open_issues_count
    #   project.labels.count.should == labels_count
    # end
  end

  describe '#create_github_hook' do
    it 'should create a hook on github' do
      Github::Hook.should_receive(:create)
      project.create_github_hook
    end
  end

end