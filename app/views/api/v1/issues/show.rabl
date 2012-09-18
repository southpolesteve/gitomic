object @issue
attributes :id, :body, :title, :list
child :assignee do
  attributes :login, :id
end
