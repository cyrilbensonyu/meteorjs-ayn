Meteor.methods(
  accountSuspendedEmail:(to) ->
    new Mail(to,"Account suspended","Your Account has been suspended")
)