class @Mail
  constructor:(to,subject,msg,from = null) ->
    @_opts =
      host: Meteor.settings.private.mail.sparkpost.host
      port: Meteor.settings.private.mail.sparkpost.port
      username: Meteor.settings.private.mail.sparkpost.user
      password: Meteor.settings.private.mail.sparkpost.apiKey
    @send(to,subject,msg,from)
  send:(to,subject,msg,from = null) =>
    if not from? then from = Meteor.settings.private.mail.sparkpost.defaults.from
    if not to? then throw new Meteor.Error("recipient-required","Recipient is required to send an email!")
    if not subject? then throw new Meteor.Error("subject-required","Subject is required to send an email!")
    process.env.MAIL_URL = "smtp://#{@_opts.username}:#{@_opts.password}@#{@_opts.host}:#{@_opts.port}/"
    opts = _.defaults({to:to,subject:subject,text:msg,from:from},{text:""})
    Email.send(opts)