class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :avatar

  has_many :projects

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name']
         user.email = auth['info']['email']
         user.avatar = auth['info']['image']
         user.github_token = auth['credentials']['token']
         binding.pry
      end
    end
  end

  def github
    Github.new :oauth_token => github_token
  end

  def repos
    github.repos.list
  end

  def orgs
    github.orgs.list
  end

end
