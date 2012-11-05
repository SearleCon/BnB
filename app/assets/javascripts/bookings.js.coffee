# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      dateFormat: "DD, d MM yy"
      altFormat: "yy-mm-dd"
      altField: $(this).next()
      minDate: 0
      onClose: (dateText, inst) ->
        setMinMaxDate(inst, dateText)

setMinMaxDate = (element, dateText) ->
  if element.id == 'booking_event_attributes_start_at'
    $('#booking_event_attributes_end_at').datepicker "option", "minDate", dateText
  else
    $('#booking_event_attributes_start_at').datepicker "option", "maxDate", dateText

$('#room_finder').live 'click', ->
  $(this).attr('href', $(this).attr('href') + '?start_date=' + $('#booking_event_attributes_start_at').val());
  $(this).attr('href', $(this).attr('href') + '&end_date=' + $('#booking_event_attributes_end_at').val());
  $.ajax({
  type : 'GET',
  url : $(this).attr('href'),
  dataType : 'script'
  });
  return false


$('#guest').live 'cocoon:before-insert', ->
  $("#find_guest").remove()
  $("#guest a.add_fields").hide()

$(window).load ->

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



updateEvent = (the_event) ->
  $.ajax({
  type : 'PUT',
  data: { start_at: the_event.start, end_at: the_event.end }
  url : the_event.update_url,
  dataType: 'json'
  });

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




















