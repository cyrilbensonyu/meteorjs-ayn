Meteor.methods(
  isPasswordUser:() ->
    return Meteor.users.findOne(Meteor.userId()).services.password?
)