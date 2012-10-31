$ ->
  # Show a loader in the nav when any AJAX request is executing
  $('body').ajaxStart ()->
    $('.loader').show()
  $('body').ajaxStop ()->
    $('.loader').hide()

  $(".fancybox").fancybox()