Template.profileBusinessOwnerPersonalInformation.helpers(
  fbProfilePic: () ->
    profilePic = null
    if Meteor.user()
      if Meteor.user().profile.facebook
        profilePic = Meteor.user().profile.facebook.picture
    return profilePic
  currentUpload: () ->
    currentUpload = ''
    if Template.instance().currentUpload
      currentUpload = Template.instance().currentUpload.get() 
    return currentUpload
  isNull: (obj) ->   
   return obj == null
  profileImage: () ->
    return Images.findOne({ name: 'profile.png', meta: { user: Meteor.userId(), collection: 'profile' }})    
  getStates:() ->
    return States.find({})  
  getNeighborhoods: () ->
    return Neighborhoods.find({}, {sort: {name: 1}})
)