class StaticPagesController
  init: ->

  home: ->
    $('.carousel').carousel()
    Utilities.imageLoader(".carousel")

  screens: ->
    $('a[rel*=lazybox]').lazybox()

this.BnBEezy.static_pages = new StaticPagesController()
