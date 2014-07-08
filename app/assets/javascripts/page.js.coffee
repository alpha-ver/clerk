# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:change", ->
  $(".tag-tooltip").tooltip()
  $('#google-iframe').height($(window).height()-150)
  return


$(window).resize -> 
  h=$(window).height()
  $('#google-iframe').height(h-150)
  return