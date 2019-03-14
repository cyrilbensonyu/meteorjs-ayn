Meteor.methods(
  updateBusinessProfile: (data,businessId) ->
    if Roles.userIsInRole(Meteor.userId(),'administrator')
      return true if BusinessProfiles.update(businessId,{$set:data})
    else
      return true if BusinessProfiles.update({userId: Meteor.userId()}, {$set: data})
)