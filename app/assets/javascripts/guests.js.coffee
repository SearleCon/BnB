class GuestsController
  init: ->

  index: ->
    $("[rel=tooltip]").tooltip({animation:true, placement:'top'})


this.BnBEezy.guests = new GuestsController()
