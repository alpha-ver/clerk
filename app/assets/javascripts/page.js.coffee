# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:change", ->
  $(".tag-tooltip").tooltip()
  $('#gpdf').height($(window).height()-220)

  cookie_id = $.cookie('selected_teplate')
  if cookie_id == null
    #
  else
    $("#select_teplate option[value=#{cookie_id}]").attr('selected','selected')


  $(".openBtn").click (e) ->
    frameSrc    = "http://docs.google.com/gview?url=#{e.target.href}&embedded=true"
    template_id = $.cookie('selected_teplate')    
    document_id = e.target.id.split("_")[1]
    console.log e.target
    e.preventDefault()
    $("#gpdf").attr "src", frameSrc
    $("#dpdf").attr "href", "/dashboard/generate/#{document_id}/#{template_id}"
    $("#myModal").modal show: true
    return

  $("#select_teplate").change ->
    template_id = $("#select_teplate option:selected").val()
    $.cookie('selected_teplate', template_id)


$(window).resize -> 
  h=$(window).height()
  $('#gpdf').height(h-220)
  return