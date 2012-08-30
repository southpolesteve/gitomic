# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  window.icebox = new List($('#icebox'))
  window.backlog = new List($('#backlog'))

class List
  constructor: (@element)->
    @name = @element.attr('id')
    @project_id = @element.data('project_id')
    @listItems = @element.find('li')
    @element.sortable({
      connectWith: ".sortable"
    })
    @element.disableSelection()
    @element.bind "sortupdate", (event, ui) =>
      @update_list_and_position(ui.item)

  update_list_and_position: (el) =>
    current_list = el.parent().attr('id')
    if current_list == @name
      issue_id = el.data('id')
      url = "/projects/#{@project_id}/issues/#{issue_id}.js"
      data = {
        issue: {
          state: @name
        }
      }
      data['issue']["#{@name}_priority_position"] = @position(el)
      $.ajax({
        type: 'PUT',
        url: url,
        data: data,
      });

  position: (el) =>
    @element.children().index(el)
