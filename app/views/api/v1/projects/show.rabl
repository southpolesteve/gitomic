object @project
attributes :name, :owner

child :issues do
  attributes :id, :title, :body, :assignee_id
  node :labels_ids do |issue|
    issue.labels.map(&:id)
  end
end
