class StaticPagesController
  init: ->

  home: ->
    $('.carousel').carousel()

  admin: ->
    $(".best_in_place").best_in_place()




this.BnBEezy.static_pages = new StaticPagesController()
