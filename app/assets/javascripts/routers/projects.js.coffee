class Gitomic.Routers.Projects extends Backbone.Router

  initialize: (options) ->
    @el = $('#main')

  routes:
    "": "index"

  index: ->
    view = new Gitomic.Views.ProjectsIndex({ collection: Gitomic.projects })
    @el.html(view.render().$el)