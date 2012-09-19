class Gitomic.Views.ProjectsShow extends Backbone.View

  template: JST['projects/show']
  className: 'span12'

  render: ->
    @renderTemplate()
    return @

  renderTemplate: ->
    @.$el.html(@template)