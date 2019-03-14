Template.controlpanelSpecialtyTags.events(
  'submit form': (e) ->
    e.preventDefault()
    data =
      name: $(e.target).find('#newSpecialtyTagName').val()
    constraints =
      name:
        presence:
          message: "^Name is required"
    if valid = Validate(data, constraints)
# TODO show errors
    else
      SpecialtyTags.insert(data)
      Notification("Specialty Tag created!")
  'click .editSpecialtyTag': (e) ->
    e.preventDefault()
    specialtyTagId = @_id;
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

      editButton = tr.find('td button.editSpecialtyTag')
      editButton.hide()
      saveButton = $('<button>')
      saveButton.prop('type','button')
      saveButton.addClass('btn btn-success')
      saveButton.text("Save")
      saveButton.on('click',(e) ->
        SpecialtyTags.update(specialtyTagId,{$set:{name:input.val()}})
        editButton.show()
        $this.show()
        saveButton.remove()
        td.remove()
      )
      editButton.parent().prepend(saveButton)
    )
  'click .deleteSpecialtyTag': (e) ->
    e.preventDefault()
    SpecialtyTags.remove(@_id)
    Meteor.call('normalizeSpecialtyTags', @_id)
    Notification("Specialty Tag deleted!")
)