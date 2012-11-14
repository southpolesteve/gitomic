module Github
  class Comment

    attr_accessor :body, :id, :user, :created_at, :updated_at, 
                  :owner, :repo_name, :issue_number

    def initialize(owner, repo_name, issue_number, data)
      [:body, :id, :created_at, :updated_at].each do |key|
        self.send("#{key}=", data.send(key))
      end
      self.user = Github::User.new(data[:user])
      self.owner = owner
      self.repo_name = repo_name
      self.issue_number = issue_number
    end

    def self.create(user, project_owner, project_name, number, github_params)
      github = Github::Issues::Comments.new oauth_token: user.github_token
      response = github.create project_owner, project_name, number, github_params
      Github::Comment.new(project_owner, project_name, number, response)
    end

    def import
      issue = gitomic_project.issues.find_by_number(issue_number)
      issue.comments.create!(body: body, user: user.gitomic_user )
    end

    def gitomic_project
      Project.find_by_owner_and_name owner, repo_name
    end

  end
end