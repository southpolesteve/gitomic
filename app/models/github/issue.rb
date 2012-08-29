module Github
  class Issue

    attr_accessor :body, :closed_at, :created_at, :id, 
    :updated_at, :milestone, :number, :state, :title,
    :owner, :repo

    def initialize(owner, repo, data)
      @owner = owner
      @repo = repo
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

    def import
      i = issue
      attributes_map.except(:number).each do |key, value|
        i.send("#{value}=", self.send(key))
      end
      i.save!
      return i
    end

    def issue
      project.issues.find_or_initialize_by_number(number)
    end

    def project
      Project.find_by_owner_and_name owner,repo
    end

    private

    def attributes_map
      {:body => :body,
      :closed_at => :closed_at,
      :created_at => :github_created_at,
      :id => :github_id,
      :updated_at => :github_updated_at,
      :number => :number,
      :state => :github_state,
      :title => :title,
      :milestone => :milestone}
    end

  end
end