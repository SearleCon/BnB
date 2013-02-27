class BnBsController
  init: ->
    Utilities.createOverLay()
    $('.gallery').imagesLoaded ->
      $("#overlay").remove()

  show: ->
    $('.best_in_place').best_in_place()


this.BnBEezy.bnbs = new BnBsController()