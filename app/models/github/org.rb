module Github
  class Org

    attr_accessor :avatar_url, :login

    def initialize(data)
      [:avatar_url, :login].each do |key|
        self.send("#{key}=", data.send(key))
      end
    end

    def self.all(user)
      github = Github::Orgs.new oauth_token: user.github_token
      github.all.map do |org|
        Github::Org.new(org)
      end
    end

    def self.members(user, org_name)
      github = Github::Orgs.new oauth_token: user.github_token
      github.members.list(org_name).map do |member|
        Github::User.new(member)
      end
    end

    def repos(user)
      Github::Repo.all(user, org: login)
    end

  end
end