# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  window.haystack = new List($('#haystack'))

  for user in $('.draggables .user')
    $(user).data('object', new User($(user)))

  for issue in $('.issue')
    $(issue).data('object', new Issue($(issue)))

  for label in $('.draggables .label')
    $(label).data('object', new Label($(label)))

  window.List = List
  window.Issue = Issue
  window.Label = Label
  window.User = User


class List
  constructor: (@element)->
    @id = @element.data('id')
    @project_id = @element.data('project_id')
    @element.sortable({
      connectWith: ".sortable"
    })
    @element.disableSelection()
    @element.bind "sortupdate", (event, ui) =>
      @update_list_and_position(ui.item)

  update_list_and_position: (element) =>
    current_list = element.parent().data('id')
    if current_list == @list_id
      issue_id = element.data('id')
      url = "/projects/#{@project_id}/issues/#{issue_id}.js"
      data = { issue: { list_id: ( @list_id ? '' ) } }
      data['issue']["priority_position"] = @issue_position(element)
      data['issue']['assignee_id'] = element.data('assignee_id')
      data['issue']['label_ids'] = element.data('label_ids')
      $.ajax({
        type: 'PUT',
        url: url,
        data: data,
      });

  issue_position: (element) =>
    @element.children().index(element)

class Issue
  constructor: (@element)->
    @id = @element.data('id')
    @list = @element.parent().data('object')
    @bindEvents()

  bindEvents: ->
    @element.droppable({
      hoverClass: "drop-hover",
      accept: '.draggables *'
      drop: (event, ui) ->
        dropped_element = ui.draggable
        model = ui.draggable.data('object').model
        switch model
          when 'User'
            $(this).data('assignee_id', dropped_element.data('id'))
            window.haystack.update_list_and_position($(this))
            ui.helper.remove()
          when 'Label'
            label_ids = $(this).data('label_ids')
            label_ids.push(dropped_element.data('id'))
            $(this).data('label_ids', label_ids)
            window.haystack.update_list_and_position($(this))
            ui.helper.remove()
    });

class Label
  constructor: (@element)->
    @id = @element.data('id')
    @model = 'Label'
    @bindEvents()
    @element.disableSelection()

  bindEvents: ->
    @element.draggable({ helper: "clone" });


class User
  constructor: (@element)->
    @model = 'User'
    @id = @element.data('id')
    @bindEvents()

  bindEvents: ->
    @element.draggable({ helper: "clone" });
