class RoomsController
  init: ->

  index: ->
    $('.best_in_place').best_in_place()
    $("[rel=tooltip]").tooltip({animation:true, placement:'right'})


this.BnBEezy.rooms = new RoomsController()
