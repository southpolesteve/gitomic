class Issue < ActiveRecord::Base
  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title

  belongs_to :project

  def update_from_github(user)
    issue = github_issue(user)
    self.body = issue[:body]
    self.closed_at = issue.closed_at.try(:to_datetime)
    self.github_created_at = issue.created_at.try(:to_datetime)
    self.github_id = issue.id
    self.github_updated_at = issue.updated_at.try(:to_datetime)
    self.milestone = issue.milestone
    self.number = issue.number
    self.state = issue.state
    self.title = issue.title
    save!
  end

  private

  def github_issue(user)
    issues = Github::Issues.new(oauth_token: user.github_token)
    issues.get project.owner, project.name, number
  end

end
