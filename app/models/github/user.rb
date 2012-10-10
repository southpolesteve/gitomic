module Github
  class User
    attr_accessor :login, :url, :id, :avatar, :name, :email

    def initialize(data)

      [:login, :url, :id, :avatar, :name, :email].each do |key|
        self.send("#{key}=", data.try(:send, key))
      end

    end

    # def import(owner, repo)
    #   project = Project.find_by_owner_and_name(owner, repo)
    #   user = ::User.find_or_initialize_by_github_login(login)
    #   user.avatar = avatar
    #   if user.save
    #     project.users << user unless project.users.include?(user)
    #   end
    # end

    def to_s
      "#<#{self.class} login:#{login}>"
    end
  end
end