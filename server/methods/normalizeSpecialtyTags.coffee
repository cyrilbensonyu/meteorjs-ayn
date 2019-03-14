Meteor.methods(
  normalizeSpecialtyTags: (id) ->
    profiles = _.map(BusinessProfiles.find({specialties: id}).fetch(), (p) -> return p._id)
    BusinessProfiles.update({_id: {$in: profiles}}, {$pull: {specialties: id}}, {multi: true})
)