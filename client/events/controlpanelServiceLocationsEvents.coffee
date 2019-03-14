Template.controlpanelServiceLocations.events(
  'submit form': (e) ->
    e.preventDefault()
    data =
      name: $(e.target).find('#newServiceLocationName').val()
    constraints =
      name:
        presence:
          message: "^Name is required"
    if valid = Validate(data, constraints)
# TODO show errors
    else
      ServiceLocations.insert(data)
      Notification("Service Location created!")
  'click .editServiceLocation': (e) ->
    e.preventDefault()
    serviceLocationId = @_id;
    tr = $(e.target).parent().parent().parent()
    tr.find('td').not(':last-of-type').each((i) ->
      $this = $(@)

      $this.hide()

      td = $('<td>')
      formGroup = $('<div>')
      formGroup.addClass('form-group')
      inputWrapper = $('<div>')
      inputWrapper.addClass('col-md-6')
      inputWrapper.css('paddingLeft',0)
      input = $('<input>')
      input.prop('type','text')
      input.addClass('form-control')
      input.val($this.text())
      inputWrapper.append(input)
      formGroup.append(inputWrapper)
      td.append(formGroup)
      $this.after(td)

      editButton = tr.find('td button.editServiceLocation')
      editButton.hide()
      saveButton = $('<button>')
      saveButton.prop('type','button')
      saveButton.addClass('btn btn-success')
      saveButton.text("Save")
      saveButton.on('click',(e) ->
        ServiceLocations.update(serviceLocationId,{$set:{name:input.val()}})
        editButton.show()
        $this.show()
        saveButton.remove()
        td.remove()
      )
      editButton.parent().prepend(saveButton)
    )
  'click .deleteServiceLocation': (e) ->
    e.preventDefault()
    ServiceLocations.remove(@_id)
    Meteor.call('normalizeServiceLocation', @_id)
    Notification("Service Location deleted!")
)