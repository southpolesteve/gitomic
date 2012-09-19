class Gitomic.Routers.Projects extends Support.SwappingRouter

  initialize: (options) ->
    @el = $('#backbone')
    @collection = options.collection
    @model = options.model

  routes:
    "projects/:id": "show"

  show: (projectId)->
    view = new Gitomic.Views.ProjectsShow({ model: @model })
    console.log(view)
    @swap(view)