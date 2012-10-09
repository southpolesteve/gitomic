module Github
  class Label

    attr_accessor :color, :name, :owner, :repo

    def initialize(owner, repo, data)
      self.owner = owner
      self.repo = repo
      [:color, :name].each do |key|
        self.send("#{key}=", data.send(key))
      end
    end

    # def import
    #   project = Project.find_by_owner_and_name(owner, repo)
    #   project.labels.find_or_create_by_color_and_name(color, name)
    # end

  end
end