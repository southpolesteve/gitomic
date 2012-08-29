class Issue < ActiveRecord::Base
  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user

  belongs_to :project
  belongs_to :user

  validates :title, :presence => true

  state_machine :state, :initial => :icebox do
    
    event :move_to_backlog do
      transition all => :backlog
    end
    
    event :move_to_icebox do
      transition all => :icebox
    end

  end

end
