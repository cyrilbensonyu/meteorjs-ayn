#Template.frontoffice.events(
#  'click .login': (e) ->
#    $('.login-container').toggle()
#)
#
isWithinSearchTerms = (searchQuery) ->
    searchTerms = {
      'electrician' : 'electrical'
      'hvac': 'heating and air'
      'carpet cleaner': 'carpet cleaning'
      'landscaper': 'landscaping'
      'exterminator': 'pest control'
      'bugs': 'pest control'
      'painter': 'painting'
      'plumber': 'plumbing'
      'maind': 'house cleaning' 
    }

    return if typeof searchTerms[searchQuery.toLowerCase()] == 'undefined' then searchQuery else searchTerms[searchQuery.toLowerCase()]


Template.frontofficeSearch.events(
  'select2:select #frontofficeSearch': (e) ->
    profile = e.params.data.id
    FlowRouter.go(FlowRouter.path('business.view') + "/#{profile}")
)

Template.frontofficeViewBusiness.events(
  'click .rating-image': (e) ->
    $('.rating-image').removeClass('active')
    $(e.target).addClass('active')
  'click .rating-thumb': (e) ->
    $('.rating-thumb').each((i) ->
      target = $(@)
      if target.hasClass('fa-thumbs-down') then target.removeClass('fa-thumbs-down').addClass('fa-thumbs-o-down')
      else if target.hasClass('fa-thumbs-up') then target.removeClass('fa-thumbs-up').addClass('fa-thumbs-o-up')
    )
    target = $(e.target)
    if target.hasClass('fa-thumbs-o-down') then target.removeClass('fa-thumbs-o-down').addClass('fa-thumbs-down')
    else if target.hasClass('fa-thumbs-o-up') then target.removeClass('fa-thumbs-o-up').addClass('fa-thumbs-up')
  'click #cancelReview': (e) ->
# TODO reset controls
  'submit form': (e) ->
    e.preventDefault()
    data =
      name: $(e.target).find('#newReviewName').val()
      text: $(e.target).find('#newReviewText').val()
      serviceDate: $(e.target).find('#newReviewServiceDate').val()
      rating: $('.rating-image.active').data('rating')
      recommend: if $('.rating-thumb.fa-thumbs-up').length > 0 then true else false
    constraints =
      name:
        presence:
          message: "^Name is required"
      text:
        presence:
          message: "^Review is required"
      serviceDate:
        presence:
          message: "^Service Date is required"
      rating:
        presence:
          message: "^Please select a Rating"
      recommend:
        presence:
          message: "^Please choose whether to recommend this business or not"
    if valid = Validate(data, constraints)
# TODO display errors
      Notification("Please check your input and try again", "error")
    else
      BlockUI("Sending Review...")
      Meteor.call('createNewReview', data, @_id, (err, res) ->
        UnblockUI()
        if err then console.log(err)
        else
          Notification("Review sent!")
          FlowRouter.go(FlowRouter.path('index'))
      )
  'click [data-logout]': (e) ->
    e.preventDefault()
    BlockUI()
    Meteor.logoutOtherClients()
    Meteor.logout(() ->
      Meteor.setTimeout(() ->
        FlowRouter.go(FlowRouter.path('index'))
        UnblockUI()
      , 500)
    )  
  'click .leave-review': (e) ->
    e.preventDefault()
    FlowRouter.go(FlowRouter.path('business.review',{id:@_id}))
  'mouseover .suggested': (e) ->
    slideId = $(e.currentTarget).data('slide-id')
    slideIndex = $('.slide-' + slideId).data('slick-index')
    $("#featured-review-container").slick("slickGoTo", parseInt(slideIndex), true)  
)

Template.frontofficeYourNeighbors.events(
  'keyup #searchQuery':(e,tplI) ->

    $('.main-container').on("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", () ->
      $('.main-container').stop(true, true)
    )

    $('.main-container').animate({ scrollTop: $(e.currentTarget).position().top * 7 }, 'slow', () ->
      $('.main-container').off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove")
    )

    searchQuery = $(e.target).val()
    if not searchQuery? or searchQuery.length <= 0
      tplI.inactiveSearch.set(true)
    else
      searchQuery = isWithinSearchTerms(searchQuery)
      tplI.inactiveSearch.set(false)
      specialtyTags = _.toArray(_.pluck(SpecialtyTags.find({name:{$regex:".*#{searchQuery}.*",$options:"i"}}).fetch(),'_id'))
      serviceGroups = _.toArray(_.pluck(ServiceGroups.find({name:{$regex:".*#{searchQuery}.*",$options:"i"}}).fetch(),'_id'))
      results = BusinessProfiles.find({ $and: [ {suspended: false},  { $or:[
        {businessName:{$regex:".*#{searchQuery}.*",$options:"i"}}
        {businessDescription:{$regex:".*#{searchQuery}.*",$options:"i"}}
        {specialties:{$elemMatch:{$in:specialtyTags}}}
        {serviceGroup:{$in:serviceGroups}}
      ]}]},{limit:3}).fetch()
      _.each(results,(result) ->
        _reviews = Reviews.find({business:result._id}).fetch()
        ratings = _.map(_reviews,(review) -> return review.rating)
        result = _.extend(result,{reviews:_reviews})
        if _reviews.length > 0
          result = _.extend(result,{
            totalRating:_.reduce(ratings,(m,n) -> m+n).toFixed(1).toString()
            averageRating:Math.floor((_.reduce(ratings,(m,n) -> m+n))/_reviews.length).toFixed(1).toString()
          })
        else
          result = _.extend(result,{totalRating:0.toFixed(1).toString(),averageRating:0.toFixed(1).toString()})
      )
      results = _.sortBy(results,(r) -> return r.totalRating)
      tplI.searchQuery.clear()
      _.each(results,(r) ->
        tplI.searchQuery.push(r)
      )
  'submit form':(e) ->
    e.preventDefault()
  'click .seeBusinessReviews':(e) ->
    e.preventDefault()
    FlowRouter.go(FlowRouter.path('business.view',{id:@_id}) + "?prevQuery=#{encodeURIComponent($('#searchQuery').val())}")
  'click .clear-btn': (e) ->
    e.preventDefault()
    $('#searchQuery').val('').trigger('keyup')
)

Template.frontOfficeSearchBanner.events(
  'keyup #searchQuery':(e,tplI) ->

    $('.main-container').on("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", () ->
      $('.main-container').stop(true, true)
    )

    $('.main-container').animate({ scrollTop: $(e.currentTarget).position().top + $('#scrollIdentifier').position().top }, 'slow', () ->
      $('.main-container').off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove")
    )

    resultTemplateInstance = Blaze.getView($("section.your-neighbors")[0])._templateInstance
    searchQuery = $(e.target).val()
    if not searchQuery? or searchQuery.length <= 0
      resultTemplateInstance.inactiveSearch.set(true)
    else
      searchQuery = isWithinSearchTerms(searchQuery)
      resultTemplateInstance.inactiveSearch.set(false)
      specialtyTags = _.toArray(_.pluck(SpecialtyTags.find({name:{$regex:".*#{searchQuery}.*",$options:"i"}}).fetch(),'_id'))
      serviceGroups = _.toArray(_.pluck(ServiceGroups.find({name:{$regex:".*#{searchQuery}.*",$options:"i"}}).fetch(),'_id'))
      serviceGroup = ServiceGroups.findOne({name:{$regex:".*#{searchQuery}.*",$options:"i"}})
      
      if serviceGroup
        results = BusinessProfiles.find({ serviceGroup: serviceGroup._id ,suspended: false }, {limit:3}).fetch()
      else
        results = BusinessProfiles.find({ $and: [ {suspended: false}, { $or:[
          {businessName:{$regex:".*#{searchQuery}.*",$options:"i"}}
          {businessDescription:{$regex:".*#{searchQuery}.*",$options:"i"}}
          {specialties:{$elemMatch:{$in:specialtyTags}}}
          {serviceGroup:{$in:serviceGroups}}
        ]}]},{limit:3}).fetch()

      _.each(results,(result) ->
        _reviews = Reviews.find({business:result._id}).fetch()
        ratings = _.map(_reviews,(review) -> return review.rating)
        result = _.extend(result,{reviews:_reviews})
        if _reviews.length > 0
          result = _.extend(result,{
            totalRating:_.reduce(ratings,(m,n) -> m+n).toFixed(1).toString()
            averageRating:Math.floor((_.reduce(ratings,(m,n) -> m+n))/_reviews.length).toFixed(1).toString()
          })
        else
          result = _.extend(result,{totalRating:0.toFixed(1).toString(),averageRating:0.toFixed(1).toString()})
      )
      results = _.sortBy(results,(r) -> return r.totalRating)
      resultTemplateInstance.searchQuery.clear()
      _.each(results,(r) ->
        resultTemplateInstance.searchQuery.push(r)
      )
  'submit form':(e) ->
    e.preventDefault()
  'click .clear-btn': (e) ->
    e.preventDefault()
    $('#searchQuery').val('').trigger('keyup')
)

Template.frontofficeBanner.events(
  'click [data-logout]': (e) ->
    e.preventDefault()
    BlockUI()
    Meteor.logoutOtherClients()
    Meteor.logout(() ->
      Meteor.setTimeout(() ->
        FlowRouter.go(FlowRouter.path('index'))
        UnblockUI()
      , 500)
    )
)