# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->


  $('a[rel*=lazybox]').lazybox()

  $('#photo_image').bind 'change', ->
    $('#new_photo').submit()


