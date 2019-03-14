Template.profileBusinessOwnerBusinessInformation.helpers(
  getServiceGroups: () ->
    return ServiceGroups.find({})
  getServiceLocations: () ->
   	return ServiceLocations.find({})
 	getSpecialtyTags: () ->
 	  return SpecialtyTags.find({})
  businessImage: () ->
    businessProfile = BusinessProfiles.findOne({userId: Meteor.userId()})
    return Images.findOne({ name: 'business.png', meta: { user: Meteor.userId(), business: businessProfile._id, collection: 'business' }})
  currentUpload: () ->
  	currentUpload = ''
  	if Template.instance().currentUpload
  	  currentUpload = Template.instance().currentUpload.get()
	  return currentUpload
  shareUrl: (businessId) ->
    business = BusinessProfiles.findOne(businessId)
    longUrl = Meteor.absoluteUrl() + 'join/' + business._id 
    return longUrl
  hideIfNotComplete: (businessId) ->
    business = BusinessProfiles.findOne(businessId)
    return if business.step2Complete then '' else 'hidden'   
)

Template.licensingOption.helpers(
  equals: (licensingValue, optionValue) ->
  	return parseInt(licensingValue) == parseInt(optionValue)
)