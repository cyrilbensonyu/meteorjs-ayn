Template.frontofficeBanner.helpers(
  isAdmin: () ->
    return Roles.userIsInRole(Meteor.userId(),'administrator')
)

Template.frontofficeSearch.helpers(
  getBusinesses: () ->
    return BusinessProfiles.find({})
)

Template.frontofficeViewBusiness.helpers(
  getBusiness: () ->
    profile = BusinessProfiles.findOne(FlowRouter.getParam('id'))
    if profile and profile.address?
      Meteor.call('getCoordinatesByLocation',profile.address,(err,res) ->
        if err then console.log(err)
        profile = if typeof res != 'undefined' then _.extend(profile:{geo:{lat:res[0],long:res[1]}})
        if typeof res != 'undefined' and Microsoft? and Microsoft.Maps? and Microsoft.Maps.Map? and $('#map').length
          map = new Microsoft.Maps.Map($('#map')[0], {
            credentials: 'AuZVJjp0RBO72oPwWratc1IKxvP80JsXzWmnCGC4by9OG1VbcoUQTAGf5sSRJYdb',
            mapTypeId: Microsoft.Maps.MapTypeId.road,
            zoom:16,
            center:new Microsoft.Maps.Location(res[0], res[1]),
            enableHighDpi: true
          })
      )

      _reviews = Reviews.find({business:profile._id}).fetch()
      if _reviews.length > 0
        profile = _.extend(profile,{reviews:_reviews})
        ratings = _.map(_reviews,(review) -> return review.rating)
        profile = _.extend(profile,{
          totalRating:_.reduce(ratings,(m,n) -> m+n).toFixed(1).toString()
          averageRating:Math.floor((_.reduce(ratings,(m,n) -> m+n))/_reviews.length).toFixed(1).toString()
        })
      else
        profile = _.extend(profile,{totalRating:0.toFixed(1).toString(),averageRating:0.toFixed(1).toString()})
    return profile
  getReviews: () ->
    return Reviews.find({businessProfile: FlowRouter.getParam('id')},{limit:5}).fetch()
  hasReviews: () ->
    reviews = Reviews.find({businessProfile: FlowRouter.getParam('id')})
    return reviews? and reviews.count() > 0
  hasNoReviews: () ->
    reviews = Reviews.find({businessProfile: FlowRouter.getParam('id')})
    return reviews? and reviews.count() <= 0
  hasSingleReview: () ->
    reviews = Reviews.find({businessProfile: FlowRouter.getParam('id')})
    return reviews? and reviews.count() == 1
  reviewsCount: () ->
    return Reviews.find({businessProfile: FlowRouter.getParam('id')}).count()  
  getApprovalRatings: () ->
    return Reviews.find({businessProfile: FlowRouter.getParam('id'), serviceApproval: "1"},{limit:5}).fetch()
  hasApprovalRatings: () ->
    reviews = Reviews.find({businessProfile: FlowRouter.getParam('id'), serviceApproval: "1"})
    return reviews? and reviews.count() > 0
  approvalRatingCount: () ->
    reviews = Reviews.find({businessProfile: FlowRouter.getParam('id'), serviceApproval: "1"})
    return reviews.count()
  approvalRatingCountGreaterThanLimit: (approvalRatingCount) ->
    if approvalRatingCount < 5   
      return false
    else
      return parseInt(approvalRatingCount - 5)
  getSearchQueryFromParam: () ->
    return FlowRouter.getQueryParam('prevQuery')
  licensingDescription: (licensing) -> 
    description = 'Not Licensed'
    if licensing == 2 
      description = 'Licensed'
    if  licensing == 3
      description = 'No No Licensing Required'
    return description
  serviceGroupName: (serviceGroupId) ->
    serviceGroup = ServiceGroups.findOne(serviceGroupId)
    return if serviceGroup then serviceGroup.name else ''  
  serviceLocationName: (serviceLocationId) ->
    serviceLocation = ServiceLocations.findOne(serviceLocationId)
    return if serviceLocation then serviceLocation.name else ''
  specialtyName: (sepcialtyId) ->
    specialtyTag = SpecialtyTags.findOne(sepcialtyId)
    return if specialtyTag then specialtyTag.name else ''
  isNotOwner: () ->
    profile = BusinessProfiles.findOne(FlowRouter.getParam('id'))
    return profile.userId != Meteor.userId()
  lengthy: (content) ->
    return content.length > 200  
  truncateContent: (content) ->
    truncated = content.substring(0, 200) + '... '
    return new Handlebars.SafeString(truncated)
  getAuthor: (userId) ->
    Meteor.subscribe('userBusinessProfile', userId)
    businessProfile = BusinessProfiles.findOne({userId: userId})
    return if businessProfile and businessProfile.personal then businessProfile.personal.firstName + ' ' + businessProfile.personal.lastName else 'Anonymous'
  hasNotMadeReview: () ->
    review = Reviews.find({user: Meteor.userId()})
    return review? and review.count() <= 0
  averageRating: () ->
    total = 0
    ctr = 0
    reviews = Reviews.find({businessProfile: FlowRouter.getParam('id')}).fetch()

    _.each(reviews, (review) ->
      ctr++
      total += parseFloat(review.serviceRating)
    )

    average = total/ctr

    if average > 9
      return parseInt(average)  
    return average.toFixed(1)
  ratingImage: (averageRating) ->
    if parseFloat(averageRating) > 4.6
      return '/images/sam/sam-5-medium.png' 
    else if parseFloat(averageRating) > 3.5 and parseFloat(averageRating) < 4.6
      return '/images/sam/sam-4-medium.png'
    else if parseFloat(averageRating) > 2.5 and parseFloat(averageRating) < 3.6
      return '/images/sam/sam-3-medium.png'
    else if parseFloat(averageRating) > 1.5 and parseFloat(averageRating) < 2.6
      return '/images/sam/sam-2-medium.png'   
    else
      return '/images/sam/sam-1-medium.png'    
  rated: (serviceRating) ->
    stars = []
    for x in [0...serviceRating] by 1
      stars.push(x)

    return stars
  maxRating: (serviceRating) ->
    total = 5 - parseInt(serviceRating)  
    stars = []
    for x in [0...total] by 1
      stars.push(x)

    return stars
  profileImage: (userId) ->
    return Images.findOne({ name: 'profile.png', meta: { user: userId, collection: 'profile' }})
  fbProfile: (userId) ->
    Meteor.subscribe('userList')
    user = Meteor.users.findOne(userId)
    if user
      return user
    return null  
  businessPhoto: () ->
    business = BusinessProfiles.findOne(FlowRouter.getParam('id'))
    return Images.findOne({name: "business.png", meta: { user: business.userId, business: business._id, collection: "business" }})
  defaultImage: (serviceGroupIds) ->
    Meteor.subscribe('serviceGroups')
    if _.isArray(serviceGroupIds) and serviceGroupIds.length > 0
      serviceGroupId = serviceGroupIds[Math.floor(Math.random()*serviceGroupIds.length)]
      serviceGroup = ServiceGroups.findOne(serviceGroupId)
      if serviceGroup
        return '/images/categories/' + serviceGroup.name.toLowerCase() + '/' + parseInt(Math.floor(Math.random() * (3 - 1 + 1)) + 1) + '.jpg'     
    else
      return '/images/default.jpg'
)

Template.frontofficeYourNeighbors.helpers(
  getSearchResults:() ->
    return Template.instance().searchQuery.list()
  hasSearchResults: () ->
    return Template.instance().searchQuery.array().length
  isInactiveSearch: () ->
    return Template.instance().inactiveSearch.get()
  isActiveSearch: () ->
    return not Template.instance().inactiveSearch.get()
  noSearchResults: () ->
    return not Template.instance().inactiveSearch.get() and Template.instance().searchQuery.array().length <= 0
  isNotLoggedIn: (user) -> 
    return Meteor.user() == null
  hasReviews: (businessId) ->
    reviews = Reviews.find({businessProfile: businessId})
    return reviews? and reviews.count() > 0  
  getApprovalRatings: (businessId) ->
    return Reviews.find({businessProfile: businessId, serviceApproval: "1"}).fetch()
  hasApprovalRatings: (businessId) ->
    reviews = Reviews.find({businessProfile: businessId, serviceApproval: "1"})
    return reviews? and reviews.count() > 0  
  averageRating: (businessId) ->
    total = 0
    ctr = 0
    reviews = Reviews.find({businessProfile: businessId}).fetch()

    _.each(reviews, (review) ->
      ctr++
      total += parseFloat(review.serviceRating)
    )
    average = total/ctr

    if average > 9
      return parseInt(average) 
    return average.toFixed(1) 
  profileImage: (userId) ->
    return Images.findOne({ name: 'profile.png', meta: { user: userId, collection: 'profile' }})
  fbProfile: (userId) ->
    Meteor.subscribe('userList')
    user = Meteor.users.findOne(userId)
    if user
      return user.profile.facebook
    return null   
  businessPhoto: (businessId) ->
    business = BusinessProfiles.findOne(businessId)
    return Images.findOne({name: "business.png", meta: { user: business.userId, business: business._id, collection: "business" }})
  defaultImage: (serviceGroupIds) ->
    Meteor.subscribe('serviceGroups')
    if _.isArray(serviceGroupIds) and serviceGroupIds.length > 0
      serviceGroupId = serviceGroupIds[Math.floor(Math.random()*serviceGroupIds.length)]
      serviceGroup = ServiceGroups.findOne(serviceGroupId)
      if serviceGroup
        return '/images/categories/' + serviceGroup.name.toLowerCase() + '/' + parseInt(Math.floor(Math.random() * (3 - 1 + 1)) + 1) + '.jpg' 
    else 
      return '/images/default.jpg'
  serviceGroupHasReviews: (serviceGroupName) ->
    reviews = null
    serviceGroup = ServiceGroups.findOne({ name: serviceGroupName })
    businessProfiles = if serviceGroup then BusinessProfiles.find({ serviceGroup: serviceGroup._id }) else null

    if businessProfiles? and businessProfiles.count()
      _.each(businessProfiles.fetch(), (businessProfile) ->
        reviews = Reviews.find({ businessProfile: businessProfile._id })
      )
      
    return if reviews? and reviews.count() > 0 then reviews.count() else false    
)

Template.frontOfficeBannerCustom.helpers(
  business: () ->
    return BusinessProfiles.findOne(FlowRouter.getParam('id'))
)