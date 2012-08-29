module Github
  class API
    include HTTParty

    format :json
    base_uri 'https://api.github.com'

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

    def orgs
      raise "WIP"
    end

    def labels( owner, repo )
      array = []
      @last_response = self.class.get "/repos/#{owner}/#{repo}/labels"
      @last_response.each do |data|
        array << Github::Label.new(data)
      end
      array
    end

    def issues( owner, repo )
      array = []
      @last_response = self.class.get "/repos/#{owner}/#{repo}/issues"
      @last_response.each do |data|
        array << Github::Issue.new(data)
      end
      array
    end

    def create_issue( owner, repo, params )
      @last_response = self.class.post "/repos/#{owner}/#{repo}/issues", :body => params.to_json
    end

    def create_label( owner, repo, params )
      @last_response = self.class.post "/repos/#{owner}/#{repo}/labels", :body => params.to_json
    end

    def update_issue
      #WIP
    end

    def create_comment
      #WIP
    end

    def rate_limit
      @last_response.headers["x-ratelimit-limit"]
    end

    def rate_limit_remaining
      @last_response.headers["x-ratelimit-remaining"]
    end

    def success?
      @last_response.code == 200
    end

  end
end