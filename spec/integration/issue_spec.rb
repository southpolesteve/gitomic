require 'spec_helper'

describe "updating an issue" do
  let(:user){ FactoryGirl.create :test_user }
  let(:project){ FactoryGirl.create :imported_project, creator: user }

  before do
    Github::Issue.stub update: FactoryGirl.build(:github_issue)
  end

  it 'changes the priority of the issue', :js do
    issue_1 = FactoryGirl.create :issue, project: project, user: user
    issue_2 = FactoryGirl.create :issue, project: project, user: user
    original_priority = issue_2.priority
    login user
    visit project_path(project)
    drop_place = page.find(:css, 'ul.list li:first')
    page.find(:css, 'ul.list li:last').drag_to(drop_place)
    wait_for_ajax
    original_priority.should_not eq(issue_2.reload.priority)
  end
end

describe "creating an issue" do
  let(:user){ FactoryGirl.create :test_user }
  let(:project){ FactoryGirl.create :imported_project, creator: user }

  before do
    Github::Issue.stub create: FactoryGirl.build(:github_issue)
  end

  it 'creates the issue', :js do
    login user
    visit project_path(project)
    click_on "New Issue"
    wait_until { page.find('.modal').visible? }
    within '.modal' do
      fill_in "Title", :with => 'A test issue'
      click_on "Create Issue"
    end
    page.should have_content('A test issue')
  end
end