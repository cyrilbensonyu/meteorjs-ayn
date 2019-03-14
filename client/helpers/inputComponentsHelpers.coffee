Template.textInput.helpers(
  formatName: (name) ->
    if name and name? and name.length > 0
      name.replace(/([A-Z])/g, ' $1').replace(/^./, (str) -> str.toUpperCase())
  getType: (type) ->
    if type then type else "text"
  withLabel: (label) ->
    if not label? or label then true else false
)

Template.textInputAdmin.helpers(
  formatName: (name) ->
    if name and name? and name.length > 0
      name.replace(/([A-Z])/g, ' $1').replace(/^./, (str) -> str.toUpperCase())
  getType: (type) ->
    if type then type else "text"
  withLabel: (label) ->
    if not label? or label then true else false
)

Template.openingHoursSelect.helpers(
  formatDay: (day) ->
    return day.charAt(0).toUpperCase() + day.slice(1)
  getTimesOptions: () ->
    startTime = moment().startOf('day').minute(0)
    endTime = moment().startOf('day').minute(0).add(30, 'minutes')
    startTimes = []
    endTimes = []
    _(10).times((i) ->
      startTimes.push(startTime.clone().add((i + 1) * 30, 'minutes'))
    )
    _(15).times((i) ->
      endTimes.push(endTime.clone().add((i + 1) * 30, 'minutes'))
    )
    console.log(startTimes, endTimes)
    options = []
    _.each(endTimes, (endTime) ->
      _.each(startTimes, (startTime) ->
        options.push(
          value: "#{endTime.format('HH:MM')}-#{startTime.format('HH:MM')}"
          text: "#{endTime.format('HH:MM')}-#{startTime.format('HH:MM')}"
        )
      )
    )
    return options
)

Template.openingHoursTimePicker.helpers(
  formatDay: (day) ->
    return day.charAt(0).toUpperCase() + day.slice(1)
)