class BookingsController
  init: ->

  new: ->
    setFormElements()

  edit: ->
    setFormElements()

  setFormElements = ->
    $("input.datepicker").each (i) ->
      $(this).datepicker
        dateFormat: "DD, d MM yy"
        altFormat: "yy-mm-dd"
        altField: $(this).next()
        minDate: Date.today()
        onSelect: (dateText, inst) ->
          previous = $(this).data("previous-value")
          $('#room_finder').trigger('click') unless new Date(previous).getTime() == new Date(dateText).getTime()
          $(this).data "previous-value", $(this).val()
          if inst.id == 'booking_event_attributes_start_at'
            $('#booking_event_attributes_end_at').datepicker "option", "minDate", dateText
          else
            $('#booking_event_attributes_start_at').datepicker "option", "maxDate", dateText


    $('#rooms').on 'click','#room_finder', ->
      AjaxHelper.read
        url: $(this).attr('href')
        params: { start_at: $('#booking_event_attributes_start_at').datepicker("getDate"), end_at: $('#booking_event_attributes_end_at').datepicker("getDate") }
        response: 'script'
      return false


this.BnBEezy.guest_bookings = new BookingsController()


