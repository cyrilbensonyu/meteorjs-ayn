Neighborhoods.allow(
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
  city:
    type: String
)

Neighborhoods.attachSchema(schema)

Neighborhoods.helpers(
  cityName:() ->
    location = ServiceLocations.findOne(@city)
    return location.name if location
)