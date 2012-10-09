module Github
  class Issue

    attr_accessor :body, :closed_at, :created_at, :id, 
    :updated_at, :milestone, :number, :state, :title,
    :labels, :url, :assignee

    def initialize(data)
      [:body, :id, :number, :state, :title].each do |key|
        self.send("#{key}=", data.send(key))
      end

      self.created_at = Time.parse(data.created_at) if data.created_at
      self.updated_at = Time.parse(data.updated_at) if data.updated_at
      self.closed_at = Time.parse(data.closed_at) if data.closed_at

    end

    def self.list_repo(user, owner, repo_name, opts = {})
      issues = []
      github = Github::Issues.new oauth_token: user.github_token
      github.list_repo(owner, repo_name, opts).each do |issue|
        issues << Github::Issue.new(issue)
      end
      issues
    end

  end
end