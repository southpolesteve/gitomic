window.Gitomic =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (data)-> 
    console.log "Backbone initiated!"
    projects = new Gitomic.Collections.Projects(data.projects)
    new Gitomic.Routers.Projects({ projects: projects })
    Backbone.history.start()

