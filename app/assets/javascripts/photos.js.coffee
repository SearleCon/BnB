class PhotosController
  init: ->

  index: ->
    $('a[rel*=lazybox]').lazybox()


this.BnBEezy.photos = new PhotosController()