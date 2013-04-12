class StaticPagesController
  init: ->

  home: ->
    $('.carousel').carousel()
    Utilities.imageLoader(".carousel")

  admin: ->
    $(".best_in_place").best_in_place()

  screens: ->
    $('a[rel*=lazybox]').lazybox()


this.BnBEezy.static_pages = new StaticPagesController()
