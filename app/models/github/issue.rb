module Github
  class Issue

    attr_accessor :created_at, :full_name

    def initialize(data)
      [:full_name].each do |key|
        self.send("#{key}=", data.send(key))
      end

      self.created_at = Time.parse(data.created_at)

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