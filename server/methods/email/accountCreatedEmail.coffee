Meteor.methods(
  accountCreatedEmail:(to) ->
    new Mail(to,"Account created","Your Account has been created")
)