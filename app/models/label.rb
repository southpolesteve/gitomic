class Label < ActiveRecord::Base
  attr_accessible :color, :name, :list

  has_many :issue_labels, :dependent => :destroy
  has_many :issues, :through => :issue_labels, :uniq => true
  has_many :list_issues, :class_name => 'Issue', :foreign_key => 'list_id'

  def text_color
    rgb = color.scan(/../).map {|color| color.to_i(16)}
    brightness = ((rgb[0]*299) + (rgb[1]*587) + (rgb[2]*114)) / 1000
    if brightness < 186
      "ffffff"
    else
      "303030"
    end
  end

end
