module Github
  class User

    attr_accessor :login, :url, :id, :avatar, :name, :email

    def initialize(data)
      @login = data["login"]
      @url = data["url"]
      @id = data["id"]
      @avatar = data["avatar_url"]
      @name = data["name"]
      @email = data["email"]
    end

    def to_s
      "#<#{self.class} login:#{login}, id:#{id}>"
    end

  end
end