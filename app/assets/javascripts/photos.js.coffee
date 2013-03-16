class PhotosController
  init: ->
    $('#photoform').on "click", "#browse_files", ->
      $(".image_file").click()

    $('#photoform').on "change", ".image_file", ->
      $("#filepath").val $(".image_file").val().split("/").pop().split("\\").pop()
      contentType = $("input:file").prop("files")[0].type.toString()
      $("#mime_field").val contentType


  index: ->
    $('a[rel*=lazybox]').lazybox()

this.BnBEezy.photos = new PhotosController()