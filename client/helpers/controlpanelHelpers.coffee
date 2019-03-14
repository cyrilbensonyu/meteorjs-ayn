Template.controlpanelSpecialtyTags.helpers(
  hasSpecialtyTags: () ->
    return SpecialtyTags.find({}).count() > 0
  getSpecialtyTags: () ->
    return SpecialtyTags.find({})
)
Template.controlpanelServiceGroups.helpers(
  hasServiceGroups: () ->
    return ServiceGroups.find({}).count() > 0
  getServiceGroups: () ->
    return ServiceGroups.find({})
)
Template.controlpanelServiceLocations.helpers(
  hasServiceLocations: () ->
    return ServiceLocations.find({}).count() > 0
  getServiceLocations: () ->
    return ServiceLocations.find({})
)
Template.controlpanelNeighborhoods.helpers(
  hasNeighborhoods: () ->
    return Neighborhoods.find({}).count() > 0
  getNeighborhoods: () ->
    return Neighborhoods.find({})
  getServiceLocations: () ->
    return ServiceLocations.find({})
)
Template.controlpanelBusinessOwners.helpers(
  hasBusinessOwners: () ->
    return BusinessProfiles.find({}).count() > 0
  getBusinessOwners: () ->
    return BusinessProfiles.find({})
  isSuspended: (suspended) ->
    return suspended? and suspended
)
Template.controlpanelEditBusinessOwner.helpers(
  getBusinessProfile: () ->
    return BusinessProfiles.findOne(FlowRouter.getParam('id'))
  getSpecialtyTags: () ->
    return SpecialtyTags.find({})
  getServiceLocations: () ->
    return ServiceLocations.find({})
  getServiceGroups: () ->
    return ServiceGroups.find({})
)