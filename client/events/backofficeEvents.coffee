Template.backoffice.events(
  'click [data-logout]': (e) ->
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