module Github
  class Hook

    attr_accessor :id, :owner, :repo_name, :created_at

    def initialize(owner, repo_name, data)
      self.owner = owner
      self.repo_name = repo_name
      self.created_at = Time.parse(data.created_at)
      self.id = data.id
    end

    def self.create(user, owner, repo_name)
      github = Github.new oauth_token: user.github_token
      response = github.repos.hooks.create owner, repo_name,
        name: "web",
        active: true,
        config: {
          url: ENV['GITHUB_WEBHOOK_URL'],
          content_type: "json"
          },
        events: %w(
          push
          issues
          issue_comment
          commit_comment
          pull_request
          member
          public
          status)
      Github::Hook.new(owner, repo_name, response)
    end

  end
end