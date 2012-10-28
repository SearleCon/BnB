# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->


   $("div").height(maxHeight)

   $('#search_country').change (event) ->
     select_wrapper = $('#order_state_code_wrapper')
     $('select', select_wrapper).attr('disabled', true)
     country_code = $(this).val()
     url = "/bnbs/sub_region_options?parent_region=" + country_code.toString()
     $.read url, (response) ->
      select_wrapper.html(response.html)






