module Github
  class Issue

    attr_accessor :body, :closed_at, :created_at, :id, 
    :updated_at, :milestone, :number, :state, :title,
    :labels, :url, :assignee, :owner, :repo_name, :user

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

      self.user = Github::User.new(data.user)
      self.assignee = Github::User.new(data.assignee)
    end

    def self.update(user, project_owner, project_name, number, github_params)
      github = Github::Issues.new oauth_token: user.github_token
      response = github.edit project_owner, project_name, number, github_params
      Github::Issue.new(project_owner, project_name, response)
    end

    def self.create(user, project_owner, project_name, github_params)
      github = Github::Issues.new oauth_token: user.github_token
      response = github.create project_owner, project_name, github_params
      Github::Issue.new(project_owner, project_name, response)
    end

    def self.list_repo(user, owner, repo_name, opts = {})
      issues = []
      github = Github::Issues.new oauth_token: user.github_token
      github.list_repo(owner, repo_name, opts).each_page do |page|
        page.map do |issue|
          issues << Github::Issue.new(owner, repo_name, issue)
        end
      end
      issues
    end

    def comments(opts = {})
      user = gitomic_project.creator
      comments = []
      github = Github::Issues.new oauth_token: user.github_token
      github.comments.all(owner, repo_name, number, opts).each_page do |page|
        page.map do |comment|
          comments << Github::Comment.new(owner, repo_name, number, comment)
        end
      end
      comments
    end

    def gitomic_issue
      gitomic_project.issues.where(number: number).first_or_initialize
    end

    def gitomic_project
      Project.find_by_owner_and_name owner, repo_name
    end

    def self.find(user, owner, repo_name, number, opts = {})
      github = Github::Issues.new oauth_token: user.github_token
      response = github.get(owner, repo_name, number, opts)
      Github::Issue.new(owner, repo_name, response)
    end

    def import
      issue = gitomic_issue
      attributes_map.except(:number).each do |key, value|
        issue.send("#{value}=", self.send(key))
      end
      labels.each do |label|
        found_label = gitomic_project.labels.where(name: label.name).first_or_initialize
        issue.labels << found_label unless issue.labels.include?(found_label)
      end
      issue.save!
      import_comments
      issue
    end

    def import_comments
      comments.map(&:import)
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
      :milestone => :milestone,
      :url => :github_url}
    end

  end
end