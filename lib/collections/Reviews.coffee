Reviews.allow(
  insert: () ->
   return Meteor.userId() 
  update: () ->
   #return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
  remove: () ->
   return true
   #return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
)

Reviews.schema = new SimpleSchema(
	user: 
		type: String

	businessProfile: 
		type: String

	serviceDate: 
		type: Date	

	serviceRating:
		type: String

	serviceApproval: 
		type: String

	content:
		type: String

	beforeImage: 
		type: String

	afterImage:
		type: String					
)