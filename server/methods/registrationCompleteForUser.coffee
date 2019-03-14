Meteor.methods(
  registrationCompleteForUser: () ->
    user = Meteor.users.findOne({_id: Meteor.userId()})
    if user then user.profile.registrationComplete
)