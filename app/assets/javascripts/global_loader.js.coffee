$(document).ready ->

  # rooms and guests
  $('.best_in_place').best_in_place()
  $("[rel=tooltip]").tooltip({animation:true, placement:'right'})

  # country and region select
  $('#bnb_country').change (event) ->
    select_wrapper = $('#order_state_code_wrapper')
    $('select', select_wrapper).attr('disabled', true)
    country_code = $(this).val()
    url = "/bnbs/sub_region_options?parent_region=" + country_code.toString()
    $.ajax({
    type : 'GET',
    url : url,
    dataType : 'script'
    });

  # photos
  $('a[rel*=lazybox]').lazybox()

  $('#browse_files').click ->
    $('#photo_image').click()

  $('#photo_image').bind 'change', ->
    $('#photo_filepath').val($('#photo_image').val())


  #bookings
  $("input.datepicker").each (i) ->
    $(this).datepicker
      dateFormat: "DD, d MM yy"
      altFormat: "yy-mm-dd"
      altField: $(this).next()
      minDate: 0
      onClose: (dateText, inst) ->
        setMinMaxDate(inst, dateText)

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
    url: /events/,
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


