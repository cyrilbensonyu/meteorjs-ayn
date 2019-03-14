@IndexRoutes = FlowRouter.group(
  prefix: '/'
  triggersEnter: [redirectIfLoggedIn, scrollOnLoad]
)

@BusinessRoutes = FlowRouter.group(
  prefix: '/business'
  triggersEnter: [redirectIfLoggedIn, scrollOnLoad]
)

@ApplicationRoutes = FlowRouter.group(
  prefix: '/app'
  triggersEnter: [redirectIfNotLoggedIn, redirectIfIncompleteProfile, redirectIfAdministrator,redirectIfSuspended, scrollOnLoad]
)

@AuthRoutes = FlowRouter.group(
  prefix: '/auth'
  triggersEnter: [redirectIfLoggedIn, scrollOnLoad]
)

@AdminRoutes = FlowRouter.group(
  prefix: '/admin'
  triggersEnter: [redirectIfNotAdministrator, scrollOnLoad]
)

@JoinRoutes = FlowRouter.group(
  prefix: '/join'
  triggersEnter: [scrollOnLoad]
)

@ErrorRoutes = FlowRouter.group(
  prefix: '/error'
#  triggersEnter: []
)