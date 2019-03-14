Template.profileBusinessOwner.onCreated(() ->
  @autorun(() ->
    Meteor.subscribe('currentBusinessProfile', Meteor.userId())
    Meteor.subscribe('serviceGroups')
    Meteor.subscribe('serviceLocations')
    Meteor.subscribe('specialtyTags')
    Meteor.subscribe('states')
    Meteor.subscribe('neighborhoods')
  )
)

Template.profileBusinessOwnerBusinessInformation.onRendered(() ->
  Meteor.setTimeout(() ->
    $('select.select2').each((i) ->
      $this = $(@)
      if $this.data('selected')
        #console.log("setting value #{$this.data('selected').split(',')}")
        $this.val($this.data('selected').split(',')).trigger('change')
    )
  , 500)

  copy = new Clipboard('.copy-url')

  this.currentUpload = new ReactiveVar(false)
)

Template.profileBusinessOwnerPersonalInformation.onRendered(() ->
  this.currentUpload = new ReactiveVar(false)
)