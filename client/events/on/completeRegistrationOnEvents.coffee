Template.completeRegistration.onCreated(() ->
  @autorun(() ->
    Meteor.subscribe('serviceGroups')
    Meteor.subscribe('serviceLocations')
    Meteor.subscribe('specialtyTags')
    Meteor.subscribe('states')
    Meteor.subscribe('neighborhoods')
  )
)

Template.completeRegistrationPart1.onCreated(() ->
	this.currentUpload = new ReactiveVar(false)

	@autorun(() ->
    Meteor.subscribe('currentBusinessProfile', Meteor.userId())
  )
)

Template.completeRegistrationPart2.onRendered(() ->
	this.currentUpload = new ReactiveVar(false)

	@autorun(() ->
    Meteor.subscribe('currentBusinessProfile', Meteor.userId())
  )
)

Template.completeRegistrationPart2.onRendered(() ->
	$('.timepicker').timepicker()
)