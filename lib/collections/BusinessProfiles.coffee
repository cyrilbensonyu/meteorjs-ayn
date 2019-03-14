BusinessProfiles.allow(
  insert: () ->
    return Meteor.userId()
  update: (userId, doc) ->
    return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
  remove: () ->
    return Meteor.userId() and Roles.userIsInRole(Meteor.userId(), 'administrator')
)

BusinessProfiles.helpers(
  serviceGroupName: () ->
    serviceGroup = ServiceGroups.findOne({_id: @serviceGroup})
    return serviceGroup.name if serviceGroup
  reviews: () ->
    reviews = Reviews.find({business:@_id})
    return reviews if reviews
  numberOfReviews: () ->
    reviews = Reviews.find({business:@_id})
    if reviews
      if reviews.count() > 0 then reviews.count()
      else "Nobody"
)