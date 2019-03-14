Meteor.methods(
  updateServiceLocations: (serviceLocations) ->
    returnServiceLocations = []
    _.each(serviceLocations, (serviceLocation) ->
      _serviceLocation = ServiceLocations.findOne({name: serviceLocation})
      if not _serviceLocation
        _serviceLocation = ServiceLocations.findOne({_id: serviceLocation})
      else
        returnServiceLocations.push(_serviceLocation._id)
      if not _serviceLocation
        location = ServiceLocations.insert({name: serviceLocation})
        returnServiceLocations.push(location)
      else
        returnServiceLocations.push(_serviceLocation._id)
    )
    return returnServiceLocations
)