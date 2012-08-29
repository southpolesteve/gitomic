module Github
  class Issue

    attr_accessor :body, :closed_at, :created_at, :id, :updated_at, :milestone, :number, :state, :title

    def initialize(data)
      @body = data["body"]
      @closed_at = data["closed_at"].try(:to_datetime)
      @created_at = data["created_at"].try(:to_datetime)
      @id = data["github_id"]
      @updated_at = data["updated_at"].try(:to_datetime)
      @milestone = data["milestone"]
      @number = data["number"]
      @state = data["state"]
      @title = data["title"]
    end

  end
end