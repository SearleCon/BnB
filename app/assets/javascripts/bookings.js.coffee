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
    url: '/events',
    ignoreTimezone: false
    }],

    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5"

    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);

    eventClick: (calEvent, jsEvent, view) ->
      showBooking(calEvent)
      return false

    dayClick: (date, allDay, jsEvent, view) ->
      createBooking(date);
      $('#booking_guest_name').autocomplete
          source: $('#booking_guest_name').data('autocomplete-source')


  $('#deleteBooking').live "ajax:success", (e, data, textStatus, jqXHR) ->
    $.lazybox.close()
    $('#calendar').fullCalendar('removeEvents', data.event_id)

  $('#new_booking').live "ajax:success", (e, data, textStatus, jqXHR) ->
    $.lazybox.close()
    $('#calendar').fullCalendar('renderEvent', data)


updateEvent = (the_event) ->
  $.update "/events/" + the_event.id, {  start_at: the_event.start, end_at: the_event.end }

showBooking = (the_event) ->
  $.read the_event.url, (response) ->
    $.lazybox(response.html)

createBooking = (date) ->
  $.read "/bookings/new", {date: date },  (response) ->
    $.lazybox(response.html)
    $("input.datepicker").each (i) ->
      $(this).datepicker
        dateFormat: "DD, d MM yy"
        altFormat: "yy-mm-dd"
        altField: $(this).next()
        minDate: 0
        onClose: (dateText, inst) ->
            setMinMaxDate(inst, dateText)

    $('#booking_guest_name').autocomplete
       source: $('#booking_guest_name').data('autocomplete-source')

    $('#guest').bind 'insertion-callback', ->
      $("#find_guest").hide()
      $("#guest a.add_fields").hide()

    $('#room_finder').click ->
      $(this).attr('href', $(this).attr('href') + '?start_date=' + $('#booking_event_attributes_start_at').val());
      $(this).attr('href', $(this).attr('href') + '&end_date=' + $('#booking_event_attributes_end_at').val());
      $.read $(this).attr('href'), (response) ->
        $.each response, (item) ->
         element_id = "#booking_room_ids_" + this.id
         $(element_id).closest('label').hide()
         $(element_id).hide()

      return false






setMinMaxDate = (element, dateText) ->
  if element.id == 'booking_event_attributes_start_at'
    $('#booking_event_attributes_end_at').datepicker "option", "minDate", dateText
  else
    $('#booking_event_attributes_start_at').datepicker "option", "maxDate", dateText






