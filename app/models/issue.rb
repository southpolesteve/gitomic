class Issue < ActiveRecord::Base
  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user

  belongs_to :project
  belongs_to :user

  validates :title, :presence => true

  def github_issue(current_user)
    issues = Github::Issues.new(oauth_token: current_user.github_token)
    @response = issues.get project.owner, project.name, number
  end

  def create_github_issue(current_user)
    issues = Github::Issues.new(oauth_token: current_user.github_token)
    @response = issues.create project.owner, project.name, title: title, body: body
    update_from_github_response
  end

  def update_github_issue(current_user)
    issues = Github::Issues.new(oauth_token: current_user.github_token)
    @response = issues.edit project.owner, project.name, number, title: title, body: body
    update_from_github_response
  end

  private

  def update_from_github_response
    self.body = @response[:body]
    self.closed_at = @response.closed_at.try(:to_datetime)
    self.github_created_at = @response.created_at.try(:to_datetime)
    self.github_id = @response.id
    self.github_updated_at = @response.updated_at.try(:to_datetime)
    self.milestone = @response.milestone
    self.number = @response.number
    self.state = @response.state
    self.title = @response.title
    save!
  end

end
