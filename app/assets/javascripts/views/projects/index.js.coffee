class Gitomic.Views.ProjectsIndex extends Backbone.View

  template: JST['projects/index']

  render: ->
    @renderTemplate()
    @renderProjects()
    return @

  renderTemplate: ->
    @.$el.html(@template)

  renderProjects: ->
    @collection.each (project) =>
      view = new Gitomic.Views.Project({ model: project })
      @.$('ul.projects').append view.render().el 
