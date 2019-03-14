Meteor.methods(
  suspendBusinessOwnerAccount:(businessId) ->
    if Roles.userIsInRole(Meteor.userId(),'administrator')
      businessProfile = BusinessProfiles.findOne(businessId)
      if businessProfile
	        user = Meteor.users.findOne(businessProfile.userId)
	      	BusinessProfiles.update(businessId,{$set:{suspended:true}})
        if user
          Meteor.users.update(businessProfile.userId,{$set:{suspended:true}})

          if user.username
          	Meteor.call('accountSuspendedEmail', user.username)

      return BusinessProfiles.findOne(businessId)     
)