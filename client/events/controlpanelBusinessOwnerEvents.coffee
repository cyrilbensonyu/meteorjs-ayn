Template.controlpanelBusinessOwners.events(
  'click .suspendBusinessOwner':(e) ->
    e.preventDefault()
    Meteor.call('suspendBusinessOwnerAccount',@_id,(err, res) ->
      if err then console.log(err)
      else
        Notification("Account suspended!")
    )
  'click .remove': (e) ->
    e.preventDefault()
    Meteor.call('removeBusiness',@_id, (err, res) ->
      if err then console.log(err)
      else
        Notification("Busines removed")
    ) 
  'click .resumeBusinessOwner':(e) ->
    e.preventDefault()
    Meteor.call('resumeBusinessOwnerAccount',@_id,(err) ->
      if err then console.log(err)
      else
        Notification("Account resumed!")
    )
)