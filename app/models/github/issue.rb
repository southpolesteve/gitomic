module Github
  class Issue

    attr_accessor :body, :closed_at, :created_at, :id, 
    :updated_at, :milestone, :number, :state, :title,
    :labels, :url, :assignee, :owner, :repo_name

    def initialize(owner, repo_name, data)
      self.labels = []
      
      [:body, :id, :number, :state, :title].each do |key|
        self.send("#{key}=", data.send(key))
      end

      self.owner = owner
      self.repo_name = repo_name
      self.created_at = Time.parse(data.created_at) if data.created_at
      self.updated_at = Time.parse(data.updated_at) if data.updated_at
      self.closed_at = Time.parse(data.closed_at) if data.closed_at

      data.labels.each do |label|
        self.labels << Github::Label.new(owner, repo_name, label)
      end

    end

    def self.list_repo(user, owner, repo_name, opts = {})
      issues = []
      github = Github::Issues.new oauth_token: user.github_token
      github.list_repo(owner, repo_name, opts).each do |issue|
        issues << Github::Issue.new(owner, repo_name, issue)
      end
      issues
    end

    def gitomic_issue
      gitomic_project.issues.find_or_initialize_by_number(number)
    end

    def gitomic_project
      Project.find_by_owner_and_name owner, repo_name
    end

    # def import
    #   i = issue
    #   attributes_map.except(:number).each do |key, value|
    #     i.send("#{value}=", self.send(key))
    #   end
    #   labels.each do |label|
    #     found_label = project.labels.find_by_name(label.name)
    #     i.labels << found_label unless i.labels.include?(found_label)
    #   end
    #   i.save!

    #   return i
    # end

    # private

    # def attributes_map
    #   {:body => :body,
    #   :closed_at => :closed_at,
    #   :created_at => :github_created_at,
    #   :id => :github_id,
    #   :updated_at => :github_updated_at,
    #   :number => :number,
    #   :state => :github_state,
    #   :title => :title,
    #   :milestone => :milestone,
    #   :url => :github_url}
    # end

  end
end