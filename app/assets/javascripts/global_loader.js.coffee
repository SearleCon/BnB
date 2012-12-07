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
    $('#photo_filepath').val($('#photo_image').val().split('\\').pop())


  flashCallback = ->
    $("#flash").fadeOut()
  $("#flash").bind 'click', (ev) =>
    $("#flash").fadeOut()
  setTimeout flashCallback, 3000



