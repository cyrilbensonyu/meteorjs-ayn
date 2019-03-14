AdminRoutes.route('/',
  action: (params, queryParams) ->
    FlowRouter.go(FlowRouter.path("admin.businessOwners"))
  name: "admin.dashboard"
)

AdminRoutes.route('/businessOwners',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {template: 'controlpanelDashboard', section: 'controlpanelBusinessOwners'})
  name: "admin.businessOwners"
)

AdminRoutes.route('/businessOwners/create',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {
      template: 'controlpanelDashboard',
      section: 'controlpanelBusinessOwners',
      create: true
    })
  name: "admin.businessOwners.create"
)

AdminRoutes.route('/businessOwners/edit/:id',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {
      template: 'controlpanelDashboard',
      section: 'controlpanelBusinessOwners',
      edit: true
    })
  name: "admin.businessOwners.edit"
)

AdminRoutes.route('/homeOwners',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {template: 'controlpanelDashboard', section: 'controlpanelHomeOwners'})
  name: "admin.homeOwners"
)

AdminRoutes.route('/neighborhoods',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {template: 'controlpanelDashboard', section: 'controlpanelNeighborhoods'})
  name: "admin.neighborhoods"
)

AdminRoutes.route('/serviceGroups',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {template: 'controlpanelDashboard', section: 'controlpanelServiceGroups'})
  name: "admin.serviceGroups"
)

AdminRoutes.route('/serviceLocations',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {template: 'controlpanelDashboard', section: 'controlpanelServiceLocations'})
  name: "admin.serviceLocations"
)

AdminRoutes.route('/specialtyTags',
  action: (params, queryParams) ->
    BlazeLayout.render('controlpanel', {template: 'controlpanelDashboard', section: 'controlpanelSpecialtyTags'})
  name: "admin.specialtyTags"
)