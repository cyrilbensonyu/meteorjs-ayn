Meteor.startup(() ->
  services = Meteor.settings.private.oAuth
  _.each(services, (service, name) ->
    ServiceConfiguration.configurations.upsert({service: name}, {$set: service})
  )

  Accounts.onCreateUser((options, user) =>
    profile = if not options.profile? then {} else options.profile
    profile.registrationComplete = false
    user.profile = profile 
    recipient = user.username

    if user.services.facebook
      result = Meteor.http.get('https://graph.facebook.com/v2.8/' + user.services.facebook.id + '?access_token=' + user.services.facebook.accessToken + '&fields=first_name, last_name, email, gender, location, friends')
      if !result.error && result.data
        user.profile.facebook = result.data;
        recipient = user.profile.facebook.email
        user.profile.facebook.picture = "http://graph.facebook.com/v2.8/" + user.services.facebook.id + "/picture/?type=large"
    else
      #Meteor.call('accountCreatedEmail', recipient)
    
    return user
  )

  if Roles.getUsersInRole('administrator').count() <= 0
    user = Accounts.createUser(
      username: 'admin'
      email: 'admin@email.com'
      password: 'administrator'
    )
    Meteor.users.update({_id: user}, {
      $set:
        "profile.registrationComplete": true
    })
    Roles.addUsersToRoles(user, 'administrator')
)