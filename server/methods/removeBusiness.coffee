Meteor.methods(
	removeBusiness: (businessId) ->
		if Roles.userIsInRole(Meteor.userId(),'administrator')
			businessProfile = BusinessProfiles.findOne(businessId)
			user = Meteor.users.findOne(businessProfile.userId)
			
			if user
				Meteor.users.remove(businessProfile.userId)

			if businessProfile
				BusinessProfiles.remove(businessId)
)