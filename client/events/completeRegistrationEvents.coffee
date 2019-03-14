Template.completeRegistrationPart1.events(
  'click .submit': (e) ->
    $('#hasBusiness').val($(e.target).data('answer'))
  'submit form': (e) ->
    e.preventDefault()
    profileImage = null
    if $(e.target).find('#profileImage').length > 0
      profileImage = $(e.target).find('#profileImage').val()
    data =
      firstName: $(e.target).find('#firstName').val()
      lastName: $(e.target).find('#lastName').val()
      address: $(e.target).find('#address').val()
      city: $(e.target).find('#city').val()
      email: $(e.target).find('#email').val()
      zip: $(e.target).find('#zip').val()
      state: $(e.target).find('#state').val()
      phoneNumber: $(e.target).find('#phoneNumber').val()
      neighborhood: $(e.target).find('#neighborhood').val()
      hasBusiness: $(e.target).find('#hasBusiness').val()
      profileImage: profileImage
    constraints =
      firstName:
        presence: "^First Name is required"
      lastName:
        presence: "^Last Name is required"
      city:
        presence: "^City is required"
      email:
        presence: "^Email is required"
        email: "^Must be an email address"
      zip:
        presence: "^Zip Code is required"
      state:
        presence:
          message: "^Please select a state"  
      neighborhood:
        presence:
          message: "^Please select a neighborhood"   
    if valid = Validate(data, constraints)?
      ValidateFormEntries($(e.currentTarget))
# TODO show errors
    else
      Meteor.call('updateBusinessProfileOnRegistration', {personal: data}, (err, res) ->
        if err then console.log(err)
        else
          if res
            Notification("Profile updated!")
            if data.hasBusiness > 0
              FlowRouter.reload() 
            else
              if Session.get('business_id') and typeof Session.get('business_id') != 'undefined'
                FlowRouter.go(FlowRouter.path('business.review', {id: Session.get('business_id')})) 
              else
                FlowRouter.go(FlowRouter.path('index'))
            # Need to redirect here to finish registration
      )

  'click #browse-photo': (e) -> 
    e.preventDefault()
    $('#upload-photo').click()

  'change #upload-photo': (e, template) ->
    if e.currentTarget.files && e.currentTarget.files[0]
      profileImage = Images.findOne({ name: 'profile.png', meta: { user: Meteor.userId(), collection: 'profile' }})

      if profileImage
        profileImage.remove()

      upload = Images.insert({
        fileName: 'profile.png'
        file: e.currentTarget.files[0]
        streams: 'dynamic'
        chunkSize: 'dynamic'
        meta: 
          user: Meteor.userId()
          collection: 'profile'
      }, false)

      upload.on('start', () -> 
        template.currentUpload.set(this)
      )

      upload.on('end', (err, fileObj) -> 
        if err
          Notification('Error during upload: ' + err , 'error')
        else 
          Notification('File ' + fileObj.name + ' uploaded', 'success')

        template.currentUpload.set(false)  
      )

      upload.start()
)

Template.completeRegistrationPart2.events(
  'submit form': (e) ->
    e.preventDefault()
    businesImage = null
    website = $(e.target).find('#website').val()
    
    if $(e.target).find('#businessImage').length > 0 
      businesImage = $(e.target).find('#businessImage').val()

    if website.substr(0, 7) == "http://" or website.substr(0, 8) == "https://"
      website = website
    else 
      website = 'http://' + website  

    data =
      businessName: $(e.target).find('#businessName').val()
      firstName: $(e.target).find('#firstName').val()
      lastName: $(e.target).find('#lastName').val()
      address: $(e.target).find('#address').val()
      serviceLocations: $(e.target).find('#serviceLocations').val()
      serviceGroup: $(e.target).find('#serviceGroup').val()
      phoneNumber: $(e.target).find('#phoneNumber').val()
      website: website
      email: $(e.target).find('#email').val()
      yearsBusinessCreated: $(e.target).find('#yearsBusinessCreated').val()
      isInsured: $(e.target).find('#isInsured').prop('checked')
      isBonded: $(e.target).find('#isBonded').prop('checked')
      licensing: $(e.target).find('#licensing').val()
      businessDescription: $(e.target).find('#businessDescription').val()
      suspended: false
      businessImage: businesImage
      openingHours:
        monday_start_time: $(e.target).find('#monday-start-time').val()
        monday_end_time: $(e.target).find('#monday-end-time').val()
        tuesday_start_time: $(e.target).find('#tuesday-start-time').val()
        tuesday_end_time: $(e.target).find('#tuesday-end-time').val()
        wednesday_start_time: $(e.target).find('#wednesday-start-time').val()
        wednesday_end_time: $(e.target).find('#wednesday-end-time').val()
        thursday_start_time: $(e.target).find('#thursday-start-time').val()
        thursday_end_time: $(e.target).find('#thursday-end-time').val()
        friday_start_time: $(e.target).find('#friday-start-time').val()
        friday_end_time: $(e.target).find('#friday-end-time').val()
        saturday_start_time: $(e.target).find('#saturday-start-time').val()
        saturday_end_time: $(e.target).find('#saturday-end-time').val()
        sunday_start_time: $(e.target).find('#sunday-start-time').val()
        sunday_end_time: $(e.target).find('#sunday-end-time').val()
        availableForEmergency: $(e.target).find('#24hours').prop('checked')
    constraints =
      businessName:
        presence:
          message: "^Business Name is required"
      firstName:
        presence:
          message: "^First Name is required"
      lastName:
        presence:
          message: "^Last Name is required"
      address:
        presence:
          message: "^Address is required"
      serviceLocations:
        arrayLength:
          minLength: 1
          message: "^Please select at least one service location"
      serviceGroup:
        presence:
          message: "^Please select a service group"
      phoneNumber:
        presence:
          message: "^Phone Number is required"
      email:
        presence:
          message: "^Email is required"
      yearsBusinessCreated:
        presence: "^Years Business Created is required"
        numericality:
          onlyInteger: true
          greaterThan: 0
          notInteger: "^This should be an integer"
          notGreaterThan: "^Should be at least 1"
      businessDescription:
        presence:
          message: "^Business Description is required"
    if valid = Validate(data, constraints)?
      ValidateFormEntries($(e.currentTarget))
    else
# TODO maybe its better to move everything in one method and call it from the server
      Meteor.call('updateServiceLocations', data.serviceLocations, (err, res) ->
        if err then console.log(err)
        else
          data.serviceLocations = res if _.isArray(res) and res.length > 0
          Meteor.call('updateServiceGroups', data.serviceGroup, (err, res) ->
            if err then console.log(err)
            else
              data.serviceGroup = res if _.isArray(res) and res.length > 0
              Meteor.call('updateBusinessProfileOnRegistration', data, (err, res) ->
                if err then console.log(err)
                else
                  if res
                    Notification("Profile updated!")

                    if Session.get('business_id') and typeof Session.get('business_id') != 'undefined'
                      FlowRouter.go(FlowRouter.path('business.review', {id: Session.get('business_id')}))
                    else
                      FlowRouter.go(FlowRouter.path('index')) # Reloading is enough here, since it will trigger the enter methods again
              )
          )
      )

  'click #browse-business-photo': (e) ->
    e.preventDefault()
    $('#upload-business-photo').click()

  'change #upload-business-photo': (e, template) ->
    if e.currentTarget.files && e.currentTarget.files[0]
      businessProfile = BusinessProfiles.findOne({userId: Meteor.userId()})
      businessImage = Images.findOne({ name: 'business.png', meta: { user: Meteor.userId(), business: businessProfile._id, collection: 'business' }})

      if businessImage
        businessImage.remove()

      upload = Images.insert({
        fileName: 'business.png'
        file: e.currentTarget.files[0]
        streams: 'dynamic'
        chunkSize: 'dynamic'
        meta: 
          user: Meteor.userId()
          business: businessProfile._id
          collection: 'business'
      }, false)

      upload.on('start', () -> 
        template.currentUpload.set(this)
      )

      upload.on('end', (err, fileObj) -> 
        if err
          Notification('Error during upload: ' + err , 'error')
        else 
          Notification('File ' + fileObj.name + ' uploaded', 'success')

        template.currentUpload.set(false)  
      )

      upload.start()     
)