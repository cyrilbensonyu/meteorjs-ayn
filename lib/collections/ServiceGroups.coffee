ServiceGroups.allow(
  insert: () ->
    return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
  update: () ->
    return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
  remove: () ->
    return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
)

schema = new SimpleSchema(
  name:
    type: String
)

ServiceGroups.attachSchema(schema)