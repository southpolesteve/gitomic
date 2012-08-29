module Github
  class Label

    attr_accessor :color, :name, :owner, :repo

    def initialize(owner, repo, data)
      @owner = owner
      @repo = repo
      @color = data["color"]
      @name = data["name"]
    end

  end
end