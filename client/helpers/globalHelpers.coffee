Template.registerHelper('yesNo', (val) ->
  if val then "Yes" else "No"
)
Template.registerHelper('isPasswordUser', () ->
  Meteor.call('isPasswordUser',(err,res) ->
    if err
      console.log(err)
      return false
    else return true
  )
)
Template.registerHelper('getSocialMediaLink', (opt) ->
  if opt? then Meteor.settings.public.socialMedia.links[opt]
)
Template.registerHelper('getSupportEmail',() ->
  return Meteor.settings.public.emails.support
)
Template.registerHelper('isnt',(val) ->
  return not val? or not val
)
Template.registerHelper('formatDate',(val) ->
  return moment(val).format("MM/DD/YYYY")
)
Template.registerHelper('truncateWithEllipsis',(val,length = 50) ->
  if val.length > length
    return val.substr(0,length-3) + "..."
  else return val
)
Template.registerHelper('has',(val) ->
  return val? and val and val.length > 0
)