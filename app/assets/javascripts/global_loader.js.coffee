$(document).ready ->

  $(document).ajaxStart ->
    createOverLay()

  $(document).ajaxStop ->
    $("#overlay").remove()


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

  $(document).on 'ajax:beforeSend','.delete_photo', ->
   $(this).closest('li').toggleClass('overlay').spin("large", "white")


  flashCallback = ->
    $("#flash").fadeOut()
  $("#flash").bind 'click', (ev) =>
    $("#flash").fadeOut()
  setTimeout flashCallback, 5000


  $(".carousel").toggleClass("overlay").spin("large", "white")

  $(".carousel").imagesLoaded ->
    $(".carousel").toggleClass("overlay").spin(false)

  $(".gallery").toggleClass("overlay").spin("large", "white")

  $(".gallery").imagesLoaded ->
    $(".gallery").toggleClass("overlay").spin(false)





createOverLay = ->
  docHeight = $(document).height()
  $("body").append "<div id='overlay'></div>"
  $("#overlay").height(docHeight).css
    opacity: 0.4
    position: "fixed"
    top: 0
    left: 0
    "background-color": "black"
    width: "100%"
    "z-index": 5000
  $("#overlay").spin({ lines: 10, length: 8, width: 20, radius: 30, color: '#FFFFFF' })



