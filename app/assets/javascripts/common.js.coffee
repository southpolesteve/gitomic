$ ->
  $('body').ajaxStart ()->
    $('.loader').show()
  $('body').ajaxStop ()->
    $('.loader').hide()