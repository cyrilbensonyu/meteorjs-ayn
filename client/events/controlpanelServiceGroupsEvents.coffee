Template.controlpanelServiceGroups.events(
  'submit form': (e) ->
    e.preventDefault()
    data =
      name: $(e.target).find('#newServiceGroupName').val()
    constraints =
      name:
        presence:
          message: "^Name is required"
    if valid = Validate(data, constraints)
# TODO show errors
    else
      ServiceGroups.insert(data)
      Notification("Service Group created!")
  'click .editServiceGroup': (e) ->
    e.preventDefault()
    serviceGroupId = @_id;
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

      editButton = tr.find('td button.editServiceGroup')
      editButton.hide()
      saveButton = $('<button>')
      saveButton.prop('type','button')
      saveButton.addClass('btn btn-success')
      saveButton.text("Save")
      saveButton.on('click',(e) ->
        ServiceGroups.update(serviceGroupId,{$set:{name:input.val()}})
        editButton.show()
        $this.show()
        saveButton.remove()
        td.remove()
      )
      editButton.parent().prepend(saveButton)
    )
  'click .deleteServiceGroup': (e) ->
    e.preventDefault()
    ServiceGroups.remove(@_id)
    Meteor.call('normalizeServiceGroups', @_id)
    Notification("Service Group deleted!")
)