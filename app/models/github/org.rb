module Github
  class Org

    attr_accessor :avatar_url, :login

    def initialize(data)
      [:avatar_url, :login].each do |key|
        self.send("#{key}=", data.send(key))
      end
    end

    def self.all(user)
      orgs = []
      github = Github::Orgs.new oauth_token: user.github_token
      github.all.each do |org|
        orgs << Github::Org.new(org)
      end
      orgs
    end

    def repos(user)
      Github::Repo.all(user, org: login)
    end

  end
end