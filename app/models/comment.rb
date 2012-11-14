class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user

  validates :body, :user_id, :presence => true

  delegate :owner, :name, :to => :project, :prefix => true
  delegate :number, :to => :issue, :prefix => true

  def create_github_comment
    @github_comment = Github::Comment.create(user, project_owner, project_name, issue_number, github_data)
    save_github_response
  end

  def update_github_comment
  end

  def project
    issue.project
  end

  private

  def github_data
    { body: body }
  end

  def save_github_response
    self.github_created_at = @github_comment.created_at
    self.github_id = @github_comment.id
    self.github_updated_at = @github_comment.updated_at
    save
  end
  
end
