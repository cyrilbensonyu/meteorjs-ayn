Meteor.methods(
  updateBusinessProfileOnRegistration: (data) ->
    profile = BusinessProfiles.findOne({userId: Meteor.userId()})
    if profile?
      BusinessProfiles.update({userId: Meteor.userId()}, {$set: _.extend(data, {step2Complete: true})})
    else
      BusinessProfiles.insert(_.extend(data, {step1Complete: true, step2Complete: false, userId: Meteor.userId()}))
      Meteor.users.update({_id: Meteor.userId()}, {
        $set:
          "profile.registrationComplete": true
      })
    return true
)