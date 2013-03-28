class PhotosController
  init: ->
    $('#upload_button').prop('disabled', true)

    $('#photoform').on "click", "#browse_files", ->
      $(".image_file").click()

    $('#photoform').on "change", ".image_file", ->
      if Utilities.validateFile($("input:file").prop("files")[0])
         $('#upload_button').prop('disabled', false)
         $("#filepath").val $(".image_file").val().split("/").pop().split("\\").pop()
         contentType = $("input:file").prop("files")[0].type.toString()
         $("#mime_field").val contentType
      else
         alert "File is invalid"


  index: ->
    $('a[rel*=lazybox]').lazybox()

this.BnBEezy.photos = new PhotosController()