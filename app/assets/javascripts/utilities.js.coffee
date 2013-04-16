@Utilities =
  addParametersToURL: (url, parameterName, parameterValue) ->
    otherQueryStringParameters = ""
    urlParts = url.split("?")
    baseUrl = urlParts[0]
    queryString = urlParts[1]
    itemSeparator = ""
    if queryString
      queryStringParts = queryString.split("&")
      i = 0

      while i < queryStringParts.length
        unless queryStringParts[i].split("=")[0] is parameterName
          otherQueryStringParameters += itemSeparator + queryStringParts[i]
          itemSeparator = "&"
        i++
    newQueryStringParameter = itemSeparator + parameterName + "=" + parameterValue
    baseUrl + "?" + otherQueryStringParameters + newQueryStringParameter

  createOverLay: ->
    docHeight = $(document).height()
    $("body").append "<div id='overlay'></div>"
    $("#overlay").height(docHeight).css
      opacity: 0.4
      position: "fixed"
      top: 0
      left: 0
      "background-color": "black"
      width: "100%"
      "z-index": 5000
    $("#overlay").spin({ lines: 10, length: 8, width: 20, radius: 30, color: '#FFFFFF' })

  imageLoader: (selector) ->
   element = $(selector)
   element.disabler()
   element.disabler("option", "disable", true)
   element.toggleClass('overlay')

   element.imagesLoaded ->
    element.toggleClass('overlay')
    element.disabler()
    element.disabler("option", "disable", false)

  adjustHeights:(elem) ->
    fontstep = 2
    if $(elem).height() > $(elem).parent().height() or $(elem).width() > $(elem).parent().width()
     $(elem).css("font-size", ($(elem).css("font-size").substr(0, 2) - fontstep) + "px").css "line-height", ($(elem).css("font-size").substr(0, 2)) + "px"
     adjustHeights elem


  validateFile: (file) ->
    if !checkFileSizeValid(file)
      return false

    if file.name.match(/^\s*[a-z-._\d,\s]+\s*$/i) == null
      return false

    return true

checkFileSizeValid =  (file) ->
  iSize = 0
  iSize = (file.size / 1024)
  if iSize / 1024 > 1
    if ((iSize / 1024) / 1024) > 1
      return false
    else
      iSize = (Math.round((iSize / 1024) * 100) / 100)
      return !iSize > 1
  else
    return true













