# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->


  $('a[rel*=lazybox]').lazybox()

  $('#browse_files').click ->
    $('#photo_image').click()


  $('#photo_image').bind 'change', ->
    $('#photo_filepath').val($('#photo_image').val())






