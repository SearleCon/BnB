# execute page specific javascripts
(($, undefined_) ->
  $ ->
    $body = $("body")
    controller = $body.data("controller").replace(/\//g, "_")
    action = $body.data("action")
    activeController = BnBEezy[controller]
    if activeController isnt `undefined`
      activeController.init()  if $.isFunction(activeController.init)
      activeController[action]()  if $.isFunction(activeController[action])

) jQuery

# boostrap confirmation boxes
$.rails.allowAction = (link) ->
  return true  unless link.attr("data-confirm")
  $.rails.showConfirmDialog link
  false

$.rails.confirmed = (link) ->
  link.removeAttr "data-confirm"
  link.trigger "click.rails"

$.rails.showConfirmDialog = (link) ->
  html = undefined
  message = undefined
  message = link.attr("data-confirm")
  html = "<div class=\"modal\" id=\"confirmationDialog\">\n  <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">X<a>\n    <h3>Confirm delete</h3>\n  </div>\n  <div class=\"modal-body\">\n    <p>" + message + "</p>\n  </div>\n  <div class=\"modal-footer\">\n    <a data-dismiss=\"modal\" class=\"btn\">Cancel</a>\n    <a data-dismiss=\"modal\" class=\"btn btn-primary confirm\">OK</a>\n  </div>\n</div>"
  $(html).modal()
  $("#confirmationDialog .confirm").on "click", ->
    $.rails.confirmed link



#global ajax
$(document).ajaxStart ->
  Utilities.createOverLay()

$(document).ajaxStop ->
  $("#overlay").remove()






