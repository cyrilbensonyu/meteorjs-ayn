@BlockUI = (message, el = null) =>
  styles =
    border: "none"
    opacity: 1
    color: "#fff"
    backgroundColor: ""
    fontSize: "1.2em"
  if not message? then message = "Loading..."
  $('#loadingText').html("#{message}")
  if el?
    el = $(el)
    el.block(
      message: $('#loadingMessage')
      css: styles
    )

  else
    $.blockUI(
      message: $('#loadingMessage')
      css: styles
    )
@UnblockUI = (el = null) =>
  if el?
    el = $(el)
    el.unblock()
  else
    $.unblockUI()
@BlockUIMessage = (message) =>
  if message? then $('#loadingText').html("#{message}")