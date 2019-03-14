Template.controlpanel.events(
  'click [data-logout]': (e) ->
    e.preventDefault()
    BlockUI()
    Meteor.logoutOtherClients()
    Meteor.logout(() ->
      Meteor.setTimeout(() ->
        FlowRouter.go(FlowRouter.path('index'))
        UnblockUI()
      , 500)
    )
)

Template.controlpanelChangePassword.events(
  'submit form':(e) ->
    e.preventDefault()
    oldPassword = $(e.target).find('#adminChangePasswordCurrentPassword').val()
    newPassword = $(e.target).find('#adminChangePasswordNewPassword').val()
    newPasswordConfirmation = $(e.target).find('#adminChangePasswordConfirmNewPassword').val()
    if newPassword is newPasswordConfirmation
      Accounts.changePassword(oldPassword,newPassword,(err) ->
        if err then console.log(err)
        # TODO show error
        else
          Notification("Password changed!")
      )
)