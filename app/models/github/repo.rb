module Github
  class Repo

    attr_accessor :created_at, :full_name

    def initialize(data)
      [:full_name].each do |key|
        self.send("#{key}=", data.send(key))
      end

      self.created_at = Time.parse(data.created_at)

    end

    def self.all(user, opts = {})
      github = Github::Repos.new oauth_token: user.github_token
      github.all(opts).map do |repo|
        Github::Repo.new(repo)
      end
    end

    def self.collaborators(user, owner, repo_name)
      github = Github::Repos::Collaborators.new oauth_token: user.github_token
      github.list(owner,repo_name).map do |user|
        Github::User.new(user)
      end
    end

  end
end