# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  backlog = new List($('#icebox'))
  $('.avatar').draggable({ helper: "clone" });
  $('.label').draggable({ helper: "clone" });
  $( ".issue" ).droppable({
      hoverClass: "drop-hover",
      drop: (event, ui) ->
        model = ui.draggable.data('model')
        switch model
          when 'User'
            console.log this
    });



class List
  constructor: (@element)->
    @name = @element.attr('id')
    @list_id = @element.data('list_id')
    @project_id = @element.data('project_id')
    @listItems = @element.find('li')
    @element.sortable({
      connectWith: ".sortable"
    })
    @element.disableSelection()
    @element.bind "sortupdate", (event, ui) =>
      @update_list_and_position(ui.item)

  update_list_and_position: (element) =>
    current_list = element.parent().data('list_id')
    if current_list == @list_id
      issue_id = element.data('id')
      url = "/projects/#{@project_id}/issues/#{issue_id}.js"
      data = { issue: { list_id: ( @list_id ? '' ) } }
      data['issue']["priority_position"] = @position(element)
      $.ajax({
        type: 'PUT',
        url: url,
        data: data,
      });

  position: (element) =>
    @element.children().index(element)
