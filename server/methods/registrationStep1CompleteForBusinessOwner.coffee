Meteor.methods(
  registrationStep1CompleteForBusinessOwner: () ->
    profile = BusinessProfiles.findOne({userId: Meteor.userId()})
    if profile?
      return profile.step1Complete
    else
      return false
)