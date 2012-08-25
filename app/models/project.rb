class Project < ActiveRecord::Base
  attr_accessible :name, :owner

  belongs_to :user
  has_many :issues, :dependent => :delete_all

  def github_issues
    user.github.issues.list_repo owner, name
  end

  def import_issues
    result = user.github.issues.list_repo owner, name
    result.each do |github_issue|
      issues.create! do |issue|
        issue.body = github_issue["body"]
        issue.closed_at = github_issue["closed_at"].try(:to_datetime)
        issue.github_created_at = github_issue["created_at"].try(:to_datetime)
        issue.github_id = github_issue["github_id"]
        issue.github_updated_at = github_issue["updated_at"].try(:to_datetime)
        issue.milestone = github_issue["milestone"]
        issue.number = github_issue["number"]
        issue.state = github_issue["state"]
        issue.title = github_issue["title"]
      end
    end
    self
  end

end
