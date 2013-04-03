class StaticPagesController
  init: ->

  home: ->
    $('.carousel').carousel()
    Utilities.imageLoader(".carousel")

    $('#bnb_country').change (event) ->
      select_wrapper = $('#order_state_code_wrapper')
      $('select', select_wrapper).attr('disabled', true)
      country_code = $(this).val()
      url = Utilities.addParametersToURL("/bnbs/sub_region_options","parent_region",country_code.toString())
      $.ajax({
             type : 'GET',
             url : url,
             dataType : 'script'
             });

  screens: ->
    $('a[rel*=lazybox]').lazybox()

this.BnBEezy.static_pages = new StaticPagesController()
