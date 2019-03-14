Meteor.methods(
  normalizeServiceGroups: (id) ->
    profiles = _.map(BusinessProfiles.find({serviceGroup: id}).fetch(), (p) -> return p._id)
    BusinessProfiles.update({_id: {$in: profiles}}, {$set: {serviceGroup: null}}, {multi: true})
)