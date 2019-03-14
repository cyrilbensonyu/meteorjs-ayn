@Images = new FilesCollection(
	collectionName: 'Images'
	#allowClientCode: false
	onBeforeUpload: (file) ->
		if file.size <= 10485760 && /png|jpg|jpeg/i.test(file.extension)
			return true
		else
			Notification('Please upload image, with size equal or less than 10MB', 'error')	
)

if Meteor.isClient 
	Meteor.subscribe('files.images.all')

if Meteor.isServer 
	Meteor.publish('files.images.all', () ->
		return Images.find().cursor
	)
