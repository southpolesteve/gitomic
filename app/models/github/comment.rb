module Github
  class Comment

    attr_accessor :body, :id, :user, :created_at, :updated_at, 
                  :owner, :repo_name, :issue_number

    def initialize(owner, repo_name, issue_number, data)
      [:body, :id, :created_at, :updated_at].each do |key|
        self.send("#{key}=", data.send(key))
      end
      self.user = Github::User.new(data[:user])
      self.owner = owner
      self.repo_name = repo_name
      self.issue_number = issue_number
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