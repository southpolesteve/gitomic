require 'spec_helper'

describe Project do
  let(:user){ FactoryGirl.create(:test_user) }
  let(:project){ FactoryGirl.create(:project, creator: user) }

  describe '.import_labels' do
    before { project.import_labels }

    it "should import and save all repo labels", :vcr do
      project.labels.should have_at_least(1).items
      project.labels.should all_be_persisted
    end

    it "should update the labels imported time", :vcr do
      project.labels_imported_at.should_not be_nil
    end
  end

  describe '.import_team' do
    before { project.import_team }

    context 'for a user repo' do
      it "should import collaborators", :vcr do
        project.users.should have_at_least(2).items
        project.users.should all_be_persisted
      end
    end 

    context 'for a org repo' do
      let(:project){ FactoryGirl.create(:org_project, creator: user)}

      it "should import org members", :vcr do
        project.users.should have_at_least(2).items
        project.users.should all_be_persisted
      end
    end

    # TODO
      # it "should update the team imported time", :vcr do
    #   project.team_imported_at.should_not be_nil
    # end

  end

  describe '.import_issues' do
    before { project.import_issues }

    it "should import and save all repo issues", :vcr do
      project.issues.should have_at_least(1).items
      project.issues.should all_be_persisted
    end

    it "should update the issues imported time", :vcr do
      project.issues_imported_at.should_not be_nil
    end
  end

  describe '.import_github' do
    let(:user) { FactoryGirl.create(:test_user) }
    let(:project) { FactoryGirl.create(:project, creator: user, owner: "rails", name: "rails" )}
    let(:github_client) { user.github }
    let(:collaborator_count) { github_client.repos.collaborators.list("rails","rails").count }
    let(:open_issues_count) { github_client.repos.get("rails", "rails").open_issues_count }
    let(:labels_count) { github_client.issues.labels.list("rails","rails").count }

    
    # This test is extremely slow (2min, 300 open issues, 25 collabs) but it passes
    # it "should import a large project", :vcr do
    #   project.import_github
    #   project.users.count.should == collaborator_count
    #   project.issues.count.should == open_issues_count
    #   project.labels.count.should == labels_count
    # end
  end

end