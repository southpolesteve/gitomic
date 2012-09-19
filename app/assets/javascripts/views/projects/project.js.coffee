class Gitomic.Views.Project extends Backbone.View

  template: JST['projects/project']
  tagName: 'li'

  bindings:
    'a': {
      modelAttr: 'name',
      attributes: [{
        name: 'href'
        observe: 'url'
      }]
    }

  render: ->
    @renderTemplate()
    @stickit()
    return @

  renderTemplate: ->
    @.$el.html(@template)