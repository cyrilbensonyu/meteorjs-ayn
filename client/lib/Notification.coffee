# Create a new Notification
@Notification = (message = "", type = "success", timeout = 3000) ->
  new _Notification(type, message)

# Create a new Dialog
@Dialog = (message = "", type = "confirm", cb = null, timeout = 3000) ->
  new _Notification(type, message, cb)

# Centralized Class for creating Notifications and Dialogs
class @_Notification
  constructor: (type, message = "", cbOk = null, cbCancel = null, timeout = 3000) ->
    if type in ["alert", "success", "error", "warning", "information"]
      noty(
        layout: 'topLeft'
        theme: 'ayn'
        type: type
        text: message
#        animation:
#          open: {width: 'toggle',opacity:1},
#          close: {width: 'toggle',opacity:0},
#          easing: 'swing',
#          speed: 300
        timeout: 3000
        force: false
        closeWith: ['click', 'hover']
        buttons: false
      )
    else if type in ["confirm", "prompt"]
      if not _.isFunction(cbOk) then cbOk = () -> null
      if not _.isFunction(cbCancel) then cbCancel = () -> null
      alertify[type](message, (e, res) ->
        cbOk(e, res)
      , (e, res) ->
        cbCancel(e, res)
      )
    else
      console.log("'#{type}' is not a valid constructor!")
