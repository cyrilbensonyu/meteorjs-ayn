JoinRoutes.route('/:id',
  action: (params, queryParams) ->
  	if Meteor.userId()
  		FlowRouter.go(FlowRouter.path('index'))
  	else	
    	BlazeLayout.render('frontoffice', {template: 'index',bannerTemplate:'frontOfficeBannerCustom'})
  name: 'share'
)