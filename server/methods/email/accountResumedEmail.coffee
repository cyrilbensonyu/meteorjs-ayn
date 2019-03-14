Meteor.methods(
  accountResumedEmail:(to) ->
    new Mail(to,"Account resumed","Your Account has been resumed")
)