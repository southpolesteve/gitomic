module Github
  class Label

    attr_accessor :color, :name, :owner, :repo

    def initialize(owner, repo, data)
      @owner = owner
      @repo = repo
      @color = data["color"]
      @name = data["name"]
    end

    def import
      project = Project.find_by_name_and_owner(repo, owner)
      project.labels.find_or_create_by_color_and_name(color, name)
    end

  end
end