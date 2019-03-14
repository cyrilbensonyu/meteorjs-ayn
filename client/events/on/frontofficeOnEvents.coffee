Template.frontofficeTestimonials.onRendered(() ->
  $("#testimonials-slider, #how-to-slider").slick(
    arrows: false
    dots: true
  )
)

Template.frontoffice.onCreated(() ->
  @autorun(() ->
    Meteor.subscribe('businessProfilesForSearch')
    Meteor.subscribe('serviceGroups')
    Meteor.subscribe('serviceLocations')
    Meteor.subscribe('specialtyTags')
  )
)

Template.frontofficeViewBusiness.onCreated(() ->
  @autorun(() ->
    Meteor.subscribe('business')
    Meteor.subscribe('reviews')
    Meteor.subscribe('reviewsForOneBusiness', FlowRouter.getParam('id'))
  )
)

Template.frontofficeViewBusiness.onRendered(() ->
  Meteor.setTimeout(() -> 
    $("#featured-review-container").slick(
      arrows: false
      dots: true
    )
  , 800)
)

Template.frontOfficeBannerCustom.onCreated(() ->
  @autorun(() ->
    Meteor.subscribe('business')
  )
)

# Template.loginStandalone.onRendered(() ->
#   goBackToIndex = Meteor.setTimeout(() ->
#     FlowRouter.go(FlowRouter.path('index'))
#   ,300000)
#   @$('input[type="text"]').on('keypress keyup keydown',(e) ->
#     Meteor.clearTimeout(goBackToIndex)
#     goBackToIndex = Meteor.setTimeout(() ->
#       FlowRouter.go(FlowRouter.path('index'))
#     ,300000)
#   )
# )

# Template.signUpStandalone.onRendered(() ->
#   goBackToIndex = Meteor.setTimeout(() ->
#     FlowRouter.go(FlowRouter.path('index'))
#   ,300000)
#   @$('input[type="text"]').on('keyup',(e) ->
#     Meteor.clearTimeout(goBackToIndex)
#     goBackToIndex = Meteor.setTimeout(() ->
#       FlowRouter.go(FlowRouter.path('index'))
#     ,300000)
#   )
# )

Template.frontofficeYourNeighbors.onCreated(() ->
  Template.instance().searchQuery = new ReactiveArray([])
  Template.instance().inactiveSearch = new ReactiveVar(true)

  @autorun(() ->
    Meteor.subscribe('allReviews')
  )
)

Template.frontofficeYourNeighbors.onRendered(() ->
  if FlowRouter.getQueryParam('searchQuery')?
    $('#searchQuery').val(FlowRouter.getQueryParam('searchQuery')).trigger('keyup')

  $('body').on('click', '.category', (e) ->
    $('#searchQuery').val($(this).data('category')).trigger('keyup')
  ) 
)

Template.frontOfficeSearchBanner.onRendered(() -> 
  if FlowRouter.getQueryParam('searchQuery')?
    $('#searchQuery').val(FlowRouter.getQueryParam('searchQuery')).trigger('keyup')
)