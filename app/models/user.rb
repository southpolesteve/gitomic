class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :avatar

  has_many :projects, :through => :project_memberships, :uniq => true
  has_many :issues
  has_many :project_memberships
  has_many :owned_projects, :class_name => 'Project'

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
    Github::API.new(self)
  end

  def repos
    github.repos
  end

  def orgs
    github.orgs
  end

end
