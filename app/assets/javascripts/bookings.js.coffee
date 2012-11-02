# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->


  $('#calendar').fullCalendar
    editable: true,
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    slotMinutes: 15,

    eventSources: [{
    url:  $('#get_bnb_events').val(),
    ignoreTimezone: false
    }],

    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5"

    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event)

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event)

    eventClick: (calEvent, jsEvent, view) ->
      showBooking2(calEvent)
      return false

    dayClick: (date, allDay, jsEvent, view) ->
      createBooking2(date)
      return false



$('#new_booking').live "ajax:error", (e, data, textStatus, jqXHR) ->
  $('#errors').html(data.responseText)

$('#room_finder').live 'click', ->
  $(this).attr('href', $(this).attr('href') + '?start_date=' + $('#booking_event_attributes_start_at').val());
  $(this).attr('href', $(this).attr('href') + '&end_date=' + $('#booking_event_attributes_end_at').val());
  $.read $(this).attr('href'), (response) ->
    $("#rooms_available").html(response.html)
    $('#room_finder').hide()
    $('#rooms_available').show()
  return false


$('#guest').live 'cocoon:before-insert', ->
  $("#find_guest").remove()
  $("#guest a.add_fields").hide()


updateEvent = (the_event) ->
  $.update "/events/" + the_event.id, {  start_at: the_event.start, end_at: the_event.end }

showBooking2 = (the_event) ->
  $.ajax({
  type : 'GET',
  url : the_event.url,
  dataType : 'script'
  });


createBooking2 = (date) ->
  path = $('#new_booking_path').val()
  $.ajax({
  data: { date: date }
  type : 'GET',
  url : path,
  dataType : 'script'
  });


















