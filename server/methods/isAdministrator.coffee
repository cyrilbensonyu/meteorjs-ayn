Meteor.methods(
  isAdministrator: () ->
    return Roles.userIsInRole(Meteor.userId(), 'administrator')
)