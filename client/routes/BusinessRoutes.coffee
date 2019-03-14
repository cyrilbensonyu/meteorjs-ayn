BusinessRoutes.route('/',
  action: (params, queryParams) ->
    FlowRouter.go(FlowRouter.path('index'))
)

BusinessRoutes.route('/view/:id',
  action: (params, queryParams) ->
    BlazeLayout.render('frontoffice', {template: 'frontofficeViewBusiness'})
  name: "business.view"
)

BusinessRoutes.route('/review/:id',
  action: (params, queryParams) ->
    BlazeLayout.render('frontoffice', {template: 'reviewForm'})
  name: "business.review"
)

