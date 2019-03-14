Template.profileBusinessOwner.helpers(
  getBusinessProfile: () ->
    BusinessProfiles.findOne({userId: Meteor.userId()})
)