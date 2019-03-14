Template.completeRegistrationPart1.helpers(
  address:() ->
    address = ''
    if Meteor.user()
      if Meteor.user().profile.facebook and Meteor.user().profile.facebook.location 
        address = Meteor.user().profile.facebook.location.name 
    return address 
  email: () ->
    email = ''
    if Meteor.user()
      if Meteor.user().emails
        email = Meteor.user().emails[0].address
      if Meteor.user().profile.facebook and Meteor.user().profile.facebook.email  
        email = Meteor.user().profile.facebook.email  
    return email
  firstName: () ->
    firstName = ''
    if Meteor.user()
      if Meteor.user().profile.facebook  
        firstName = Meteor.user().profile.facebook.first_name 
    return firstName 
  lastName: () ->
    lastName = ''
    if Meteor.user()
      if Meteor.user().profile.facebook 
        lastName = Meteor.user().profile.facebook.last_name 
    return lastName   
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
  profileImage: () ->
    return Images.findOne({ name: 'profile.png', meta: { user: Meteor.userId(), collection: 'profile' }})
  isNull: (obj) ->   
    return obj == null
  getStates:() ->
    return States.find({})  
  getNeighborhoods: () ->
    return Neighborhoods.find({}, {sort: {name: 1}})
)

Template.completeRegistrationPart2.helpers(
  address:() ->
    address = ''
    if Meteor.user()
      if Meteor.user().profile.facebook and Meteor.user().profile.facebook.location 
        address = Meteor.user().profile.facebook.location.name 
    return address 
  email:() ->
    email = ''
    if Meteor.user()
      if Meteor.user().emails
        email = Meteor.user().emails[0].address
      if Meteor.user().profile.facebook and Meteor.user().profile.facebook.email  
        email = Meteor.user().profile.facebook.email  
    return email
  firstName: () ->
    firstName = ''
    if Meteor.user()
      if Meteor.user().profile.facebook  
        firstName = Meteor.user().profile.facebook.first_name 
    return firstName 
  lastName: () ->
    lastName = ''
    if Meteor.user()
      if Meteor.user().profile.facebook 
        lastName = Meteor.user().profile.facebook.last_name 
    return lastName     
  getServiceGroups: () ->
    return ServiceGroups.find({})
  getServiceLocations: () ->
    return ServiceLocations.find({})
  getSpecialtyTags: () ->
    return SpecialtyTags.find({})
  currentUpload: () ->
    currentUpload = ''
    if Template.instance().currentUpload
      currentUpload = Template.instance().currentUpload.get() 
    return currentUpload  
  businessImage: () ->
    businessProfile = BusinessProfiles.findOne({userId: Meteor.userId()})
    if businessProfile
      return Images.findOne({ name: 'business.png', meta: { user: Meteor.userId(), business: businessProfile._id , collection: 'business' }})  
)