class Label < ActiveRecord::Base
  attr_accessible :color, :name, :list

  has_many :issue_labels, :dependent => :destroy
  has_many :issues, :through => :issue_labels

  belongs_to :list

  scope :without_list, where(:list_id => nil)

end
