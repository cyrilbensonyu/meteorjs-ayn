Meteor.methods(
  sendEmailFromClient:(opts) ->
    new Mail(opts)
)