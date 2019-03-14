@Mail = (to = null,subject = null,msg = null,from = null) ->
  if _.every([to,subject,msg,from],(e) -> e?)
    Meteor.call('sendEmailFromClient',{to:to,subject:subject,msg:msg,from:from},(err) ->
      if err then console.log(err)
      else true
    )
  else
    console.log("Missing or invalid parameters: #{JSON.stringify({to:to,subject:subject,msg:msg,from:from})}")