class Project < ActiveRecord::Base
  attr_accessible :name, :owner

  belongs_to :user
  has_many :issues

  def github_issues
    user.github.issues.list_repo owner, name

    res.each_page do |page|
      page.each do |repo|
        puts repo.name
      end
    end
  end

  def import_issues
    result = user.github.issues.list_repo owner, name
    result.each do |github_issue|
      issues.create! do |issue|
        issue.body = github_issue["body"]
        issue.closed_at = github_issue["closed_at"]
        issue.github_created_at = github_issue["github_created_at"]
        issue.github_id = github_issue["github_id"]
        issue.github_updated_at = github_issue["github_updated_at"]
        issue.milestone = github_issue["milestone"]
        issue.number = github_issue["number"]
        issue.state = github_issue["state"]
        issue.title = github_issue["title"]
      end
    end
  end

end
