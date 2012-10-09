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
      repos = []
      github = Github::Repos.new oauth_token: user.github_token
      github.all(opts).each do |repo|
        repos << Github::Repo.new(repo)
      end
      repos
    end

  end
end