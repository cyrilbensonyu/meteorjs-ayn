Template.controlpanelEditBusinessOwner.events(
  'submit form':(e) ->
    e.preventDefault()
    data =
      businessName: $(e.target).find('#businessName').val()
      firstName: $(e.target).find('#firstName').val()
      lastName: $(e.target).find('#lastName').val()
      address: $(e.target).find('#address').val()
      serviceLocations: $(e.target).find('#serviceLocations').val()
      serviceGroup: $(e.target).find('#serviceGroup').val()
      phoneNumber: $(e.target).find('#phoneNumber').val()
      website: $(e.target).find('#website').val()
      email: $(e.target).find('#email').val()
      yearsBusinessCreated: $(e.target).find('#yearsBusinessCreated').val()
      isInsured: $(e.target).find('#isInsured').prop('checked')
      isLicensed: $(e.target).find('#isLicensed').prop('checked')
      isBonded: $(e.target).find('#isBonded').prop('checked')
      businessDescription: $(e.target).find('#businessDescription').val()
      specialties: $(e.target).find('#specialties').val()
      openingHours:
        monday: $(e.target).find('#openingHoursMonday').val()
        tuesday: $(e.target).find('#openingHoursTuesday').val()
        wednesday: $(e.target).find('#openingHoursWednesday').val()
        thursday: $(e.target).find('#openingHoursThursday').val()
        friday: $(e.target).find('#openingHoursFriday').val()
        saturday: $(e.target).find('#openingHoursSaturday').val()
        sunday: $(e.target).find('#openingHoursSunday').val()
        availableForEmergency: $(e.target).find('#24hours').prop('checked')
      personal:
        firstName: $(e.target).find('#personal-firstName').val()
        lastName: $(e.target).find('#personal-lastName').val()
        address: $(e.target).find('#personal-address').val()
        city: $(e.target).find('#personal-city').val()
        email: $(e.target).find('#personal-email').val()
        zip: $(e.target).find('#personal-zip').val()
        phoneNumber: $(e.target).find('#personal-phoneNumber').val()
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
        presence: "^Years in Business is required"
        numericality:
          onlyInteger: true
          greaterThan: 0
          notInteger: "^This should be an integer"
          notGreaterThan: "^Should be at least 1"
      businessDescription:
        presence:
          message: "^Business Description is required"
      "personal.firstName":
        presence:
          message:"^First Name is required"
      "personal.lastName":
        presence:
          message:"^Last Name is required"
      "personal.city":
        presence:
          message:"^City is required"
      "personal.email":
        presence:
          message:"^Email is required"
        email:
          message:"^Must be an email address"
      "personal.zip":
        presence:
          message:"^Zip Code is required"
    if valid = Validate(data, constraints)?
      # TODO show errors
      Notification("Please check your input and try again", "error")
    else
      # TODO maybe its better to move everything in one method and call it from the server
      businessId = @_id
      console.log(businessId)
      Meteor.call('updateServiceLocations', data.serviceLocations, (err, res) ->
        if err then console.log(err)
        else
          data.serviceLocations = res if _.isArray(res) and res.length > 0
          Meteor.call('updateSpecialtyTags', data.specialties, (err, res) ->
            if err then console.log(err)
            else
              data.specialties = res if _.isArray(res) and res.length > 0
              Meteor.call('updateBusinessProfile', data,businessId, (err, res) ->
                if err then console.log(err)
                else
                  if res
                    Notification("Profile updated!")
                    FlowRouter.go(FlowRouter.path('admin.businessOwners'))
              )
          )
      )
)