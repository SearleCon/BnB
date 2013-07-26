class StaticPagesController
  init: ->

  home: ->
    #Utilities.imageLoader(".carousel")
    $('img').unveil()
    $('.carousel').carousel()

  admin: ->
    $(".best_in_place").best_in_place()




this.BnBEezy.static_pages = new StaticPagesController()
