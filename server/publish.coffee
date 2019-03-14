Meteor.publish('userList', () -> 
  return Meteor.users.find({});
)
Meteor.publish('serviceGroups', () ->
  return ServiceGroups.find({})
)
Meteor.publish('serviceLocations', () ->
  return ServiceLocations.find({})
)
Meteor.publish('specialtyTags', () ->
  return SpecialtyTags.find({})
)
Meteor.publish('reviews', () ->
  return Reviews.find({})
)
Meteor.publish('states', () ->
  return States.find({})
)
Meteor.publish('business', () ->
  return BusinessProfiles.find({})
)
Meteor.publish('currentBusinessProfile', (userId) ->
  if @userId and userId and @userId is userId then BusinessProfiles.find({userId: userId})
)
Meteor.publish('userBusinessProfile', (userId) ->
  return BusinessProfiles.find({userId: userId})
)
Meteor.publish('businessProfilesForSearch', () ->
  return BusinessProfiles.find({}, {fields: {personal: 0}})
)
Meteor.publish('businessProfilesForAdmin', () ->
  if @userId and Roles.userIsInRole(@userId,'administrator') then BusinessProfiles.find({})
)
Meteor.publish('reviewsForOneBusiness', (businessId) ->
  return Reviews.find({business: businessId})
)
Meteor.publish('allReviews', () ->
  return Reviews.find({},{$fields:{business:1,rating:1,recommend:1}})
)
Meteor.publish('neighborhoods',() ->
  return Neighborhoods.find({})
)
