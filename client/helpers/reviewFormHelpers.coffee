Template.reviewForm.helpers(
	currentUpload: () ->
    currentUpload = ''
    if Template.instance().currentUpload
      currentUpload = Template.instance().currentUpload.get() 
    return currentUpload
  imageBeforeFile: () ->
    return Images.findOne({ name: 'before.png', meta: { user: Meteor.userId(), business: FlowRouter.getParam('id'), collection: 'reviews' }})	
  imageAfterFile: () ->
  	return Images.findOne({ name: 'after.png', meta: { user: Meteor.userId(), business: FlowRouter.getParam('id'), collection: 'reviews' }})	
)