require 'spec_helper'

describe "updating an issue" do
  let(:user){ FactoryGirl.create :test_user }
  let(:project){ FactoryGirl.create :imported_project, creator: user }

  it 'changes the priority of the issue', :js do
    Github::Issue.stub update: FactoryGirl.build(:github_issue)
    issue_1 = FactoryGirl.create :issue, project: project, user: user
    issue_2 = FactoryGirl.create :issue, project: project, user: user
    original_priority = issue_2.priority
    login user
    visit project_path(project)
    drop_place = page.find(:css, 'ul.list li:first')
    page.find(:css, 'ul.list li:last').drag_to(drop_place)
    wait_until do
      page.evaluate_script('$.active') == 0
    end
    original_priority.should_not eq(issue_2.reload.priority)
  end


end