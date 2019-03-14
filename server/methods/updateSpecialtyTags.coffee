Meteor.methods(
  updateSpecialtyTags: (specialtyTags) ->
    returnSpecialtyTags = []
    _.each(specialtyTags, (specialtyTag) ->
      _specialtyTag = SpecialtyTags.findOne({name: specialtyTag})
      if not _specialtyTag
        _specialtyTag = SpecialtyTags.findOne({_id: specialtyTag})
      else
        returnSpecialtyTags.push(_specialtyTag._id)
      if not _specialtyTag
        tag = SpecialtyTags.insert({name: specialtyTag})
        returnSpecialtyTags.push(tag)
      else
        returnSpecialtyTags.push(_specialtyTag._id)
    )
    return returnSpecialtyTags
)