class @AjaxHelper

  @read: (opts = {}) ->
    opts.verb = 'GET'
    sendRequest(opts)

  @update: (opts = {}) ->
    opts.verb = 'PUT'
    sendRequest(opts)

  @patch: (opts = {}) ->
    opts.verb = 'PATCH'
    sendRequest(opts)

  @create: (opts = {}) ->
    opts.verb = 'POST'
    sendRequest(opts)

  @destroy: (opts = {}) ->
    opts.verb = 'DELETE'
    sendRequest(opts)



  sendRequest = (opts = {}) ->
    opts.response ?= 'json'
    $.ajax({
           type: opts.verb,
           data: opts.params,
           url: opts.url,
           dataType: opts.response,
           success: opts.success,
           error: opts.error
           });
