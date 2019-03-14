ApplicationRoutes.route('/',
  action: (params, queryParams) ->
    FlowRouter.go(FlowRouter.path('app.profile'))
)

ApplicationRoutes.route('/profile',
  triggersEnter: [redirectIfAdministrator]
  action: (params, queryParams) ->
# TODO determine correct template based on device and user type
    BlazeLayout.render('backoffice', {template: 'profileBusinessOwner'})
  name: 'app.profile'
)

ApplicationRoutes.route('/completeRegistration',
  action: (params, queryParams) ->
# TODO determine correct template based on device and user type
    userType = "businessowner"
    switch userType
      when "businessowner"
        Meteor.call('registrationStep1CompleteForBusinessOwner', (err, res) ->
          if err then console.log(err)
          else
            if res
              stepTemplate = "completeRegistrationPart2"
            else
              stepTemplate = "completeRegistrationPart1"
            BlazeLayout.render('backoffice', {template: 'completeRegistration', registrationStepTemplate: stepTemplate,registrationIsStep1:!res})
        )
        break
      when "homeowner"
        break
  name: 'app.completeRegistration'
)