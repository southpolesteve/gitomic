object @issue
attributes :id, :body, :title,
child :assignee do
  attributes :login, :id
end
