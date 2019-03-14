@Validate = require('validate.js')
@Validate.validators.arrayLength = (value, options, key, attributes) ->
  if not options.minLength? then options.minLength = 1
  messages = []
  if not _.isArray(value) then messages.push("Is not an array")
  if value.length < options.minLength then messages.push("Should contain at least #{options.minLength} elements")
  if messages.length > 0
    if options.message then options.message else ""
  else
    null