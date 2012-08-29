module Github
  class Repo

    attr_accessor :full_name

    def initialize(data)
      @full_name = data['full_name']
    end

    def owner
      full_name.split("/")[0]
    end
    
    def name
      full_name.split("/")[1]
    end

  end
end