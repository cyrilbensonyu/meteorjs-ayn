Meteor.methods(
  accountIsSuspended:() ->
    account = Meteor.users.findOne(Meteor.userId())
    if account and account.suspended
#      Meteor.users.update(Meteor.userId(),{$set:{"services.resume.loginTokens":[]}})
      return true
    else
      return false
)