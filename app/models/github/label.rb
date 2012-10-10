module Github
  class Label

    attr_accessor :color, :name, :owner, :repo_name

    def initialize(owner, repo_name, data)
      self.owner = owner
      self.repo_name = repo_name
      [:color, :name].each do |key|
        self.send("#{key}=", data.send(key))
      end
    end

    def self.list(user, owner, repo_name, opts ={})
      github = Github::Issues.new oauth_token: user.github_token
      github.labels.list(owner, repo_name, opts).each do |label|
        Github::Label.new(owner, repo_name, label)
      end
    end

    def import
      label = gitomic_label
      label.color = color
      label.name = name
      label.save!
      label
    end

    def gitomic_label
      gitomic_project.labels.where(name: name).first_or_initialize
    end

    def gitomic_project
      Project.where(owner: owner, name: repo_name).first
    end

    def to_s
      "<Github::Label name:#{name}>"
    end

  end
end