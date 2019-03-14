Template.accountSuspended.events(
  'click #backToHomepageAndLogout':(e) ->
    e.preventDefault()
    BlockUI()
    Meteor.logoutOtherClients()
    Meteor.logout(() ->
      Meteor.setTimeout(() ->
        FlowRouter.go(FlowRouter.path('index'))
        UnblockUI()
      , 500)
    )
)