class Project < ActiveRecord::Base
  attr_accessible :name, :owner, :org

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'

  has_many :issues, :dependent => :destroy
  has_many :labels, :dependent => :destroy
  has_many :lists, :class_name => 'Label', :conditions => ['list = ?' , true]
  has_many :project_memberships, :dependent => :destroy
  has_many :users, :through => :project_memberships, :uniq => true

    
  def import_github
    import_labels
    import_team
    import_issues
    update_attribute(:imported_at, Time.now)
  end

  def import_github_async
    Resque.enqueue( ImportProject, self.id )
  end

  def import_labels
    github_labels.map(&:import)
    update_attribute(:labels_imported_at, Time.now)
  end

  def import_issues
    github_issues.map(&:import)
    update_attribute(:issues_imported_at, Time.now)
  end

  def import_team
    github_team.each{ |github_user| github_user.import(owner, name) }
  end

  def github_labels
    creator.github.labels owner, name
  end

  def github_issues
    Github::Issue.list_repo creator, owner, name
  end

  def github_collaborators
    creator.github.collaborators owner, name
  end

  def github_org_members
    creator.github.org_members name
  end

  def github_team
    org ? github_org_members : github_collaborators
  end

  def create_github_hook
    #WIP
  end

end
