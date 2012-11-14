require 'spec_helper'

describe "destroying a project" do
 
  before do
    project = FactoryGirl.create :project
    issue = FactoryGirl.create :issue, project: project 
    issue.comments << Comment.create!(body: 'test', user: project.creator)
    login project.creator
    visit settings_project_path(project)
    click_link "Destroy"
  end

  it "should display a flash" do
    page.should have_content("Project has been destroyed")
  end

  it "should delete the project" do
    Project.all.should be_empty
  end

  it "should delete the issue" do
    Issue.all.should be_empty
  end

  it "should delete the comment" do
    Comment.all.should be_empty
  end
end