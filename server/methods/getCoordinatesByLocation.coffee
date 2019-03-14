Meteor.methods(
  getCoordinatesByLocation:(address) ->
    result = HTTP.get("http://dev.virtualearth.net/REST/v1/Locations?q=" +  encodeURIComponent(address.trim()) + "&key=AuZVJjp0RBO72oPwWratc1IKxvP80JsXzWmnCGC4by9OG1VbcoUQTAGf5sSRJYdb")
    if result.data? and result.data.resourceSets? and result.data.resourceSets[0].resources.length > 0
      resource = result.data.resourceSets[0].resources[0]
      return resource.point.coordinates  
)