Meteor.methods(
	createReview: (data) ->
		businessId = data.businessProfile
		Reviews.insert(data, (err, res) ->
			if err then Notification(err, 'error')
			if res then return res
		)
)