class PhotosController
  init: ->

  index: ->
    Utilities.createOverLay()
    $('a[rel*=lazybox]').lazybox()
    $('.gallery').imagesLoaded ->
      $("#overlay").remove()


this.BnBEezy.photos = new PhotosController()