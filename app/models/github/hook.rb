module Github
  class Hook

    attr_accessor :events, :active, :last_response, :created_at, :name, :config

    def initialize(owner, repo, data)
      @owner = owner
      @repo = repo
      @events = data["events"]
      @active = data["active"]
      @last_response = data["last_response"]
      @created_at = data["created_at"]
      @name = data["name"]
      @config = data["config"]
      @id = data["id"]
      @url = data["url"]
    end

  end
end