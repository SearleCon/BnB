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













