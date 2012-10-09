class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :avatar

  has_many :projects, :through => :project_memberships, :uniq => true
  has_many :issues
  has_many :project_memberships
  has_many :owned_projects, :class_name => 'Project'
  has_many :assigned_issues, :class_name => 'Issue', :foreign_key => 'assignee_id'

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name']
         user.email = auth['info']['email']
         user.avatar = auth['info']['image']
         user.github_token = auth['credentials']['token']
         user.github_login = auth['extra']['raw_info']['login']
      end
    end
  end

  def github
    Github.new oauth_token: self.github_token
  end

  def github_repos
    Github::Repo.all(self)
  end

  def github_orgs
    Github::Org.all(self)
  end

  def github_org_repos
    repos = []
    github_orgs.each do |org|
      repos.concat github.repos(org: org.login).all
    end
    repos
  end

end
