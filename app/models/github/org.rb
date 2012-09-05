module Github
  class Org

    attr_accessor :name, :avatar, :id

    def initialize(data)
      @name = data['login']
      @avatar = data['avatar_url']
      @id = data['id']
    end

    def repos(user)
      github = Github::API.new(user)
      github.org_repos name
    end

  end
end