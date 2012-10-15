module Github
  class User
    attr_accessor :login, :url, :id, :avatar_url, :name, :email

    def initialize(data)

      [:login, :url, :id, :avatar_url, :name, :email].each do |key|
        self.send("#{key}=", data.try(:send, key))
      end

    end

    def import(owner, name)
      project = Project.where(owner: owner, name: name).first
      if project
        user = ::User.find_or_initialize_by_github_login(login)
        user.avatar = avatar_url
        if user.save
          project.users << user unless project.users.include?(user)
        end
      end
    end

    def to_s
      "#<#{self.class} login:#{login}>"
    end
  end
end