Template.reviewForm.onCreated(() ->
  this.currentUploadBefore = new ReactiveVar(false)
  this.currentUploadAfter = new ReactiveVar(false)
  
  @autorun(() ->
    Meteor.subscribe('reviewsForOneBusiness', FlowRouter.getParam('id'))
  )
)

Template.reviewForm.onRendered(() ->
	$('.service-date').datepicker(
    format: 'yyyy-m-d'
    autoclose: true
  )
)