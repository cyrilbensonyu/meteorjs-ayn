Meteor.methods(
  updateServiceGroups: (serviceGroups) ->
    returnServiceGroups = []
    _.each(serviceGroups, (serviceGroup) ->
      _serviceGroup = ServiceGroups.findOne({name: serviceGroup})
      if not _serviceGroup
        _serviceGroup = ServiceGroups.findOne({_id: serviceGroup})
      else
        returnServiceGroups.push(_serviceGroup._id)
      if not _serviceGroup
        group = ServiceGroups.insert({name: serviceGroup})
        returnServiceGroups.push(group)
      else
        returnServiceGroups.push(_serviceGroup._id)
    )
    return returnServiceGroups
)