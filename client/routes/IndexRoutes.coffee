IndexRoutes.route('/',
  action: (params, queryParams) ->
    BlazeLayout.render('frontoffice', {template: 'index',bannerTemplate:'frontofficeBannerIndex'})
  name: 'index'
)