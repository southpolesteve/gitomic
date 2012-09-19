window.Gitomic =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (data)-> 
    @projects = new Gitomic.Collections.Projects(data.projects)

    new Gitomic.Routers.Projects({ collection: @projects})
    Backbone.history.start({pushState: true})

    #Used to prevent browser from following links
    $(document).on 'click', 'a:not([data-bypass])', (e) ->
      href = $(this).attr('href')
      protocol = this.protocol + '//'
      if  href.slice(protocol.length) != protocol 
        e.preventDefault()
        Gitomicrouter.navigate(href, true)

