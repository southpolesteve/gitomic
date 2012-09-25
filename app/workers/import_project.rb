class ImportProject
  @queue = :import

  def self.perform(project_id)
    project = Project.find(project_id)
    project.import_github
  end

end