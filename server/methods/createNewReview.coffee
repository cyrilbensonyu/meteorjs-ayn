Meteor.methods(
  createNewReview: (data, business) ->
    Reviews.insert(_.extend(data, {business: business}))
)