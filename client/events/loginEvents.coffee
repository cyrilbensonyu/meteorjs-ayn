Template.login.events(
  'click #loginWithFacebook': (e) ->
    BlockUI()
    opts =
      requestPermissions: Meteor.settings.public.facebookPermissions
    Meteor.loginWithFacebook(opts, (err) ->
      UnblockUI()
      if err
        console.log(err)
        Notification("Error while logging in", "error")
      else
        Notification("Login successful")
        FlowRouter.go(FlowRouter.path('app.profile'))
    )
  'submit #loginForm': (e) ->
    e.preventDefault()
    BlockUI()
    data =
      email: $(e.target).find('[name="login-email"]').val()
      password: $(e.target).find('[name="login-password"]').val()
    constraints =
      email:
        presence:
          message: "^Please enter an email address"
        email:
          message: "^Must be an email address"
      password:
        presence:
          message: "^Please enter a password"
    if valid = Validate(data, constraints)?
# TODO display errors
      Notification("Please check your input and submit again", "error")

    else
      Meteor.loginWithPassword(data.email, data.password, (err) ->
        UnblockUI()
        if err
          console.log(err)
          Notification("Incorrect Email or password, try again")
        else
          Notification("Login successful")
          FlowRouter.go(FlowRouter.path('index'))
      )
)