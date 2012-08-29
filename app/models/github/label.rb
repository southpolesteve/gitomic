module Github
  class Label

    attr_accessor :color, :name

    def initialize(data)
      @color = data["color"]
      @name = data["name"]
    end

  end
end