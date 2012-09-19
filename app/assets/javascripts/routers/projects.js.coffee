class Gitomic.Routers.Projects extends Support.SwappingRouter

  initialize: (options) ->
    @el = $('#main_content')
    @collection = options.collection

  routes:
    "projects": "index"
    "projects/:id": "show"

  index: ->
    view = new Gitomic.Views.ProjectsIndex({ collection: @collection })
    @swap(view)

  show: (projectId)->
    view = new Gitomic.Views.ProjectsIndex({ collection: @collection })
    @swap(view)