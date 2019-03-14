States.allow(
  insert: () ->
   return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
  update: () ->
   return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
  remove: () ->
   return true
   #return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
)

States.schema = new SimpleSchema(
	name: 
		type: String				
)