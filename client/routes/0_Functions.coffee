BlazeLayout.setRoot('body')

FlowRouter.notFound =
  action:() ->
    FlowRouter.go(FlowRouter.path('util.error',{errorCode:404}))

@scrollOnLoad = () ->
  $('.main-container').scrollTop(0)
@redirectIfLoggedIn = () ->
  #if Meteor.userId() then FlowRouter.go(FlowRouter.path('app.profile'))
@redirectIfNotLoggedIn = () ->
  if not Meteor.userId() then FlowRouter.go(FlowRouter.path('app.login'))
@redirectIfIncompleteProfile = () ->
  Meteor.call('registrationCompleteForUser', Meteor.userId(), (err, res) ->
    if err then console.log(err)
    else
      if not res
        if FlowRouter.getRouteName() isnt "app.completeRegistration"
          FlowRouter.go(FlowRouter.path('app.completeRegistration'))
  )
@redirectIfAdministrator = () ->
  Meteor.call('isAdministrator', (err, res) ->
    if err then console.log(err)
    else
      if res then FlowRouter.go(FlowRouter.path('admin.dashboard'))
  )
@redirectIfNotAdministrator = () ->
  Meteor.call('isAdministrator', (err, res) ->
    if err then console.log(err)
    else
      if not res then FlowRouter.go(FlowRouter.path('app.profile'))
  )
@redirectIfSuspended = () ->
  Meteor.call('accountIsSuspended',(err,res) ->
    if err then console.log(err)
    else
      if res then FlowRouter.go(FlowRouter.path('util.accountSuspended'))
  ) 