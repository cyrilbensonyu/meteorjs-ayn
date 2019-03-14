AuthRoutes.route('/login',
  action: (params, queryParams) ->
    BlazeLayout.render('frontoffice', {template:'index',bannerTemplate: 'loginStandalone'})
  name: 'auth.login'
)

AuthRoutes.route('/signup',
  action: (params, queryParams) ->
    BlazeLayout.render('frontoffice', {template:'index',bannerTemplate: 'signUpStandalone'})
  name: 'auth.signup'
)

AuthRoutes.route('/resetpassword',
  action: (params, queryParams) ->
    BlazeLayout.render('frontoffice', {template:'index',bannerTemplate: 'resetPasswordStandalone'})
  name: 'auth.resetPassword'
)