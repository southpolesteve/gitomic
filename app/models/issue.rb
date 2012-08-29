class Issue < ActiveRecord::Base
  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user

  belongs_to :project
  belongs_to :user

  validates :title, :presence => true

  delegate :owner, :name, :to => :project, :prefix => true


  def update_github(user)
    if new_record?
      Github::Issue.create(user, project_owner, project_name, github_params)
    else
      Github::Issue.update(user, project_owner, project_name, number, github_params)
    end
  end

  def github_params
    { :body => body,
      :title => title,
    }
  end

end
