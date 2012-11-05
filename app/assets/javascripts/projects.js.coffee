# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  for list in $('.list')
    new List($(list))

  for user in $('.draggables .user')
    new User($(user))

  for issue in $('.issue')
    new Issue($(issue))

  for label in $('.draggables .label')
    new Label($(label))

  window.List = List
  window.Issue = Issue
  window.Label = Label
  window.User = User


class List
  constructor: (@element)->
    @id = @element.data('id')
    @project_id = @element.data('project_id')
    @element.sortable
      connectWith: ".sortable",
      placeholder: 'drop-placeholder',
      start: (event, ui) ->
        ui.placeholder.height(ui.item.height())

    @element.disableSelection()
    @element.bind "sortupdate", (event, ui) =>
      unless ui.sender
        $(ui.item).trigger 'issue:update'

class Issue
  constructor: (@element)->
    @id = @element.data('id')
    @bindEvents()

  bindEvents: ->
    @element.droppable({
      hoverClass: "drop-hover",
      accept: '.draggables *'
      drop: (event, ui) ->
        dropped_element = ui.draggable
        model = ui.draggable.data('model')
        switch model
          when 'User'
            $(this).data('assignee_id', dropped_element.data('id'))
            $(this).trigger('issue:update')
            ui.helper.remove()
          when 'Label'
            label_ids = $(this).data('label_ids')
            label_ids.push(dropped_element.data('id'))
            $(this).data('label_ids', label_ids)
            $(this).trigger('issue:update')
            ui.helper.remove()
    })

    @element.bind 'issue:update', (event) =>
      @save()

    @element.find('a').bind 'click', (event) =>
      event.preventDefault()
      $('#issue').load("/projects/#{@project_id()}/issues/#{@id}")

  save: ->
    url = "/projects/#{@project_id()}/issues/#{@id}.js"
    data = { issue: {} }
    data['issue']["priority_position"] = @position()
    data['issue']['assignee_id'] = @assignee_id()
    data['issue']['label_ids'] = @label_ids()
    data['issue']['list_id'] = @list_id()
    $.ajax({
      type: 'PUT',
      url: url,
      data: data,
    });

  list_id: ->
    @element.parent().data('id')

  project_id: ->
    @element.parent().data('project_id')

  assignee_id: ->
    @element.data('assignee_id')

  label_ids: ->
    @element.data('label_ids') ? []

  position: ->
    @element.index()


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
