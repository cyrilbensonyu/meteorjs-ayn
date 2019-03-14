@ErrorCode = (code) ->
  codes =
    "404":
      title:"Page not found"
      text:"It seems that this page does not exist."
    "500":
      title:"An error has occurred"
      text:"We're sorry, this usually doesn't happen. An administrator has been informed and is probably already working on a solution. Please try again later."
  return codes[code] if codes[code]?