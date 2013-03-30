class BookingsController
  init: ->
    setFormElements()

  index: ->
    $('#calendar').fullCalendar
      header:
        left: 'prev,next today',
        center: 'title',
      defaultView: 'month',
      height: 600,
      slotMinutes: 15,
      eventSources: [{
                     url: '/events',
                     ignoreTimezone: false
                     }],

      timeFormat: 'h:mm t{ - h:mm t} ',
      dragOpacity: "0.5"

      eventClick: (calEvent, jsEvent, view) ->
        AjaxHelper.read
          url: calEvent.url
          response: 'script'
        return false

      dayClick: (date, allDay, jsEvent, view) ->
        if date < Date.today()
         $('#calendar').fullCalendar('today')
         bootbox.alert "The selected date is invalid, date must be today or greater."
        else
         window.location.href = Utilities.addParametersToURL($('#new_booking_path').val(),"date",date)

        return false

  show_invoice: ->
    $('.best_in_place').best_in_place()
    $('#line_items').on 'ajax:success', '.best_in_place', ->
      AjaxHelper.read
       url : $('#booking_total_path').val()
       response: 'script'

  setFormElements = ->
    $("input.datepicker").each (i) ->
      $(this).datepicker
        dateFormat: "DD, d MM yy"
        altFormat: "yy-mm-dd"
        altField: $(this).next()
        minDate: date.today
        onSelect: (dateText, inst) ->
          previous = $(this).data("previous-value")
          $('#room_finder').trigger('click') unless new Date(previous).getTime() == new Date(dateText).getTime()
          $(this).data "previous-value", $(this).val()
          if inst.id == 'booking_event_attributes_start_at'
            $('#booking_event_attributes_end_at').datepicker "option", "minDate", dateText
          else
            $('#booking_event_attributes_start_at').datepicker "option", "maxDate", dateText

    $('#booking_guest_id').select2({
       width: 'element',
       placeholder: 'Search for a guest'
       });

    $('#guest').on 'cocoon:before-insert', ->
      $("#find_guest").remove()
      $("#guest a.add_fields").hide()

    $('#rooms').on 'click','#room_finder', ->
      AjaxHelper.read
        url: $(this).attr('href')
        params: { start_at: $('#booking_event_attributes_start_at').datepicker("getDate"), end_at: $('#booking_event_attributes_end_at').datepicker("getDate") }
        response: 'script'
      return false






this.BnBEezy.bookings = new BookingsController()

