class StaticPagesController
  init: ->

  home: ->
    Utilities.imageLoader(".carousel")
    $('.carousel').carousel()

  admin: ->
    $(".best_in_place").best_in_place()

  screens: ->
    $('a[rel*=lazybox]').lazybox()


this.BnBEezy.static_pages = new StaticPagesController()
