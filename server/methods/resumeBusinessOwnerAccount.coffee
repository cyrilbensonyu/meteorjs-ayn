Meteor.methods(
  resumeBusinessOwnerAccount:(businessId) ->
    if Roles.userIsInRole(Meteor.userId(),'administrator')
      businessProfile = BusinessProfiles.findOne(businessId)
      if businessProfile
            user = Meteor.users.findOne(businessProfile.userId)
            BusinessProfiles.update(businessId,{$set:{suspended:false}})
        if user
          Meteor.users.update(businessProfile.userId,{$set:{suspended:false}})

          if user.username
            Meteor.call('accountResumedEmail',user.username)

      return BusinessProfiles.findOne(businessId)    
)