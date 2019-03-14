Meteor.methods(
  normalizeServiceLocation: (id) ->
    profiles = _.map(BusinessProfiles.find({serviceLocations: id}).fetch(), (p) -> return p._id)
    BusinessProfiles.update({_id: {$in: profiles}}, {$pull: {serviceLocations: id}}, {multi: true})
)