Template.controlpanelNeighborhoods.events(
  'submit form': (e) ->
    e.preventDefault()
    data =
      name: $(e.target).find('#newNeighborhoodName').val()
      city: $(e.target).find('#newNeighborhoodCity').val()
    constraints =
      name:
        presence:
          message: "^Name is required"
      city:
        presence:
          message: "^City is required"
    if valid = Validate(data, constraints)
      # TODO show errors
    else
      Neighborhoods.insert(data)
      Notification("Neighborhood created!")
  'click .editNeighborhood': (e) ->
    e.preventDefault()
    neighborhoodId = @_id
    tr = $(e.target).parent().parent().parent()
    tr.find('td').not('[data-when-edit="selectServiceLocation"]').not(':last-of-type').each((i) ->
      $this = $(@)

      $this.hide()

      td = $('<td>')
      formGroup = $('<div>')
      formGroup.addClass('form-group')
      inputWrapper = $('<div>')
      inputWrapper.addClass('col-md-12')
      inputWrapper.css('paddingLeft',0)
      input = $('<input>')
      input.prop('type','text')
      input.addClass('form-control')
      input.val($this.text())
      inputWrapper.append(input)
      formGroup.append(inputWrapper)
      td.append(formGroup)
      $this.after(td)
    )
    tr.find('td[data-when-edit="selectServiceLocation"]').each((i) ->
      $this = $(@)

      $this.hide()

      td = $('<td>')
      formGroup = $('<div>')
      formGroup.addClass('form-group')
      inputWrapper = $('<div>')
      inputWrapper.addClass('col-md-12')
      inputWrapper.css('paddingLeft',0)
      select = $('<select>')
      select.addClass('form-control select2')
      serviceLocations = ServiceLocations.find({}).fetch()
      _.each(serviceLocations,(serviceLocation) ->
        option = $('<option>')
        option.prop('value',serviceLocation._id)
        option.text(serviceLocation.name)
        select.append(option)
      )
      inputWrapper.append(select)
      formGroup.append(inputWrapper)
      td.append(formGroup)
      $this.after(td)
      select.select2()
      select.val(ServiceLocations.findOne({name:$this.text()})._id).trigger('change')
    )
    editButton = tr.find('td button.editNeighborhood')
    editButton.hide()
    saveButton = $('<button>')
    saveButton.prop('type','button')
    saveButton.addClass('btn btn-success')
    saveButton.text("Save")
    saveButton.on('click',(e) ->
      neighborhood =
        name: tr.find('td:visible').first().find('input').val()
        city: tr.find('td:visible select.select2').val()
      Neighborhoods.update(neighborhoodId,{$set:neighborhood})
      editButton.show()
      saveButton.remove()
      tr.find('td:visible').not('[data-when-edit="selectServiceLocation"]').not(':last-of-type').each((i) ->
        $(@).remove()
      )
      tr.find('td:hidden').show()
      tr.show()
    )
    editButton.parent().prepend(saveButton)
  'click .deleteNeighborhood': (e) ->
    e.preventDefault()
    Neighborhoods.remove(@_id)
    Meteor.call('normalizeNeighborhoods', @_id)
    Notification("Neighborhood deleted!")
)