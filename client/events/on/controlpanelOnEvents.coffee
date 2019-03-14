Template.controlpanel.onCreated(() ->
  Meteor.subscribe('specialtyTags')
  Meteor.subscribe('serviceLocations')
  Meteor.subscribe('serviceGroups')
  Meteor.subscribe('neighborhoods')
  Meteor.subscribe('businessProfilesForAdmin')
)
Template.controlpanelDashboard.onRendered(() ->
  $('#controlpanelDashboardNavigation .item').tab()
  $("#controlpanelDashboardNavigation a[href='##{@data.section()}']").tab('show')
)

Template.controlpanelEditBusinessOwner.onRendered(() ->
  Meteor.setTimeout(() ->
    $('select.select2').each((i) ->
      $this = $(@)
      if $this.data('selected')
        console.log("setting value #{$this.data('selected').split(',')}")
        $this.val($this.data('selected').split(',')).trigger('change')
    )
  , 500)
)