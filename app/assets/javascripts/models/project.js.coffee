class Gitomic.Models.Project extends Backbone.Model

  initialize: ->
    @set('url', @url() )
  
