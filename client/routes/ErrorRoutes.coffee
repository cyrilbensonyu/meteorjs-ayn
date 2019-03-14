ErrorRoutes.route('/permissionDenied',
  action: (params,queryParams) ->
    BlazeLayout.render('error',{template:'permissionDenied'})
  name:"util.permissionDenied"
)
ErrorRoutes.route('/accountSuspended',
  action: (params,queryParams) ->
    BlazeLayout.render('error',{template:'accountSuspended'})
  name:"util.accountSuspended"
)
ErrorRoutes.route('/:errorCode',
  action: (params,queryParams) ->
    BlazeLayout.render('error',{template:'40x',errorCode:ErrorCode(params.errorCode)})
  name:"util.error"
)