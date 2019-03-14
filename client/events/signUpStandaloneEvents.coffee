Template.signUpStandalone.events(
  'click #signUpWithFacebook': (e) ->
    BlockUI()
    opts =
      requestPermissions: Meteor.settings.public.facebookPermissions
    Meteor.loginWithFacebook(opts, (err, res) ->
      if err
        console.log(err)
        #Notification("An error occurred while creating your account", "error")
        Notification(err.reason || err.message, "error")
        UnblockUI()
      else
        FlowRouter.go(FlowRouter.path('app.profile'))
        UnblockUI()
    )
  'submit #signUpForm': (e) ->
    e.preventDefault()
    BlockUI()
    data =
      email: $(e.target).find('[name="signup-email"]').val()
      password: $(e.target).find('[name="signup-password"]').val()
    constraints =
      email:
        presence:
          message: "^Please enter an email address"
        email:
          message: "^Must be an email address"
      password:
        presence:
          message: "^Please enter a password"
        length:
          minimum: 8
          tooShort: "Password must be at least %{count} characters long"
    if valid = Validate(data, constraints)?
# TODO display errors
      Notification("Please check your input and submit again", "error")
      UnblockUI()
    else
      Accounts.createUser(
        username: data.email
        email: data.email
        password: data.password
      , (err) ->
        if err
          console.log(err)
          Notification("Email already exists.", "error")
          #Notification("An error occurred while creating your account", "error")
          #Notification(err.reason || err.message, "error")
          UnblockUI()
        else
          FlowRouter.go(FlowRouter.path('app.profile'))
          UnblockUI()
      )
  'click #showSignUpForm': (e) ->
    e.preventDefault()
    $(e.currentTarget).addClass('hidden')
    $('#signUpForm').removeClass('hidden')    
)