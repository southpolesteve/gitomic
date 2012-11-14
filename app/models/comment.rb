class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user

  validates :body, :user_id, :presence => true

  before_create :create_github_comment
  before_update :update_github_comment

  delegate :owner, :name, :to => :project, :prefix => true
  delegate :number, :to => :issue, :prefix => true

  def github_comment
  end

  def create_github_comment
    if on_github?
      Github::Comment.create(user, project_owner, project_name, issue_number, github_data)
    end
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

  def on_github?
    github_id.present?
  end
  
end
