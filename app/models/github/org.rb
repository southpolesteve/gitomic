module Github
  class Org

    attr_accessor

    def initialize(data)
      @name = data['login']
      @avatar = data['avatar_url']
      @id = data['id']
    end

  end
end