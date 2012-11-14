require 'spec_helper'

describe "creating a comment" do

  let(:user){ FactoryGirl.create :test_user }
  let(:project){ FactoryGirl.create :imported_project, creator: user }
  let(:issue){ FactoryGirl.create :issue, project: project, user: user }

  before do
    Github::Comment.stub create: FactoryGirl.build(:github_comment)
  end

  it 'add the comment to the page', :js do
    login user
    visit project_issue_path(project, issue)
    fill_in 'comment_body', :with => 'test comment'
    click_on 'Create Comment'
    wait_for_ajax
    within 'ul.comments' do
      page.should have_content('test comment')
    end
  end
end