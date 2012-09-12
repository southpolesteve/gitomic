module Github
  class API
    include HTTParty

    format :json
    base_uri 'https://api.github.com'

    attr_accessor :token, :last_response

    def initialize(user)
      @token = user.github_token
      self.class.default_params :access_token => @token
    end

    def repos
      array = []
      @last_response = self.class.get '/user/repos'
      @last_response.each do |data|
        array << Github::Repo.new(data)
      end
      array
    end

    def user(login)
      @last_response = self.class.get "/users/#{login}"
      Github::User.new(@last_response)
    end

    def orgs
      array = []
      @last_response = self.class.get '/user/orgs'
      @last_response.each do |data|
        array << Github::Org.new(data)
      end
      array
    end

    def org_repos(org)
      array = []
      @last_response = self.class.get "/orgs/#{org}/repos"
      @last_response.each do |data|
        array << Github::Repo.new(data)
      end
      array
    end

    def collaborators(user, repo)
      array = []
      @last_response = self.class.get "/repos/#{user}/#{repo}/collaborators"
      @last_response.each do |data|
        array << Github::User.new(data)
      end
      array
    end

    def hooks(user, repo)
      @last_response = self.class.get "/repos/#{user}/#{repo}/hooks"
    end

    def create_hook(user, repo, params)
      @last_response = self.class.post "/repos/#{user}/#{repo}/hooks", :body => params.to_json
    end

    def org_members(org)
      array = []
      @last_response = self.class.get "/orgs/#{org}/members"
      @last_response.each do |data|
        array << Github::User.new(data)
      end
      array
    end

    def labels(user, repo)
      array = []
      @last_response = self.class.get "/repos/#{user}/#{repo}/labels"
      @last_response.each do |data|
        array << Github::Label.new(user, repo, data)
      end
      array
    end

    def issues(user, repo)
      array = []
      @last_response = self.class.get "/repos/#{user}/#{repo}/issues"
      @last_response.each do |data|
        array << Github::Issue.new(user, repo, data)
      end
      array
    end

    def create_issue(user, repo, params)
      @last_response = self.class.post "/repos/#{user}/#{repo}/issues", :body => params.to_json
      Github::Issue.new(user,repo, @last_response).import
    end

    def create_label(user, repo, params)
      @last_response = self.class.post "/repos/#{user}/#{repo}/labels", :body => params.to_json
    end

    def update_issue(user, repo, number, params)
      @last_response = self.class.patch "/repos/#{user}/#{repo}/issues/#{number}", :body => params.to_json
      Github::Issue.new(user,repo, @last_response).import
    end

    def create_comment
      #WIP
    end

    def rate_limit
      if @last_response
        @last_response.headers["x-ratelimit-limit"]
      else
        self.class.get("/rate_limit")['rate']['limit']
      end
    end

    def rate_limit_remaining
      if @last_response
        @last_response.headers["x-ratelimit-remaining"]
      else
        self.class.get("/rate_limit")['rate']['remaining']
      end
    end

    def success?
      @last_response.code == 200
    end

    def to_s
      "#<#{self.class}>"
    end

  end
end