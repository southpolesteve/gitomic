collection @issues
attributes :id, :title, :body, :github_url

child :assignee => :assignee do
  attributes :login, :id, :avatar
end

child :labels => :labels do
  attributes :id, :name, :color, :list
end
