class Gitomic.Views.ProjectsIndex extends Backbone.View

  template: JST['projects/index']

  bindings:
    'a': 
      modelAttr: 'name'
      attributes: [
        {
          name: 'href'
          observe: 'id'
        }
      ]

  render: ->
    @.$el.html(JST['projects/index'])
    @.stickit()