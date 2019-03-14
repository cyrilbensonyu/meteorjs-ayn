Template.reviewForm.events(
	'change #file-after': (e, tmplt) ->
  	if e.currentTarget.files && e.currentTarget.files[0]
      afterImage = Images.findOne({ name: 'after.png', meta: { user: Meteor.userId(), business: FlowRouter.current().params.id, collection: 'reviews' }})
      
      if afterImage
        afterImage.remove()

      upload = Images.insert({
        file: e.currentTarget.files[0]
        fileName: 'after.png'
        streams: 'dynamic'
        chunkSize: 'dynamic'
        meta: 
        	user: Meteor.userId()
        	business: FlowRouter.getParam('id')
        	collection: 'reviews'
      }, false)

      upload.on('start', () -> 
        tmplt.currentUploadAfter.set(this)
      )

      upload.on('end', (err, fileObj) -> 
        if err
          Notification('Error during upload: ' + err , 'error')
        else 
          Notification('File ' + fileObj.name + ' uploaded', 'success')

        tmplt.currentUploadAfter.set(false)  
      )

      upload.start() 
	'change #file-before': (e, tmplt) ->
		if e.currentTarget.files && e.currentTarget.files[0]
      beforeImage = Images.findOne({ name: 'before.png', meta: { user: Meteor.userId(), business: FlowRouter.getParam('id'), collection: 'reviews' }})
      
      if beforeImage 
        beforeImage.remove()

      upload = Images.insert({
        file: e.currentTarget.files[0]
        fileName: 'before.png'
        streams: 'dynamic'
        chunkSize: 'dynamic'
        meta: 
        	user: Meteor.userId()
        	business: FlowRouter.getParam('id')
        	collection: 'reviews'
      }, false)

      upload.on('start', () -> 
        tmplt.currentUploadBefore.set(this)
      )

      upload.on('end', (err, fileObj) -> 
        if err
          Notification('Error during upload: ' + err , 'error')
        else 
          Notification('File ' + fileObj.name + ' uploaded', 'success')

        tmplt.currentUploadBefore.set(false)  
      )

      upload.start() 
	'click #back': (e, tmplt) ->
	  e.preventDefault()
	  FlowRouter.go(FlowRouter.path('business.view',{id: FlowRouter.getParam('id')}))
	'click .option': (e) ->
		$(e.currentTarget).find('label').addClass('selected')
		$(e.currentTarget).siblings().find('label').removeClass('selected')
		$('#service-rating').val($(e.currentTarget).data('value'))
	'click .recommendation-option-button': (e) ->
		$(e.currentTarget).addClass('selected')
		$(e.currentTarget).siblings('img').removeClass('selected')	
		$('#service-approval').val($(e.currentTarget).data('value'))
	'click .upload': (e) ->
		e.preventDefault()
		$('#' + $(e.currentTarget).data('input')).click()    
	'submit form': (e) ->
		e.preventDefault()
		beforeImage = ''
		afterImage = ''
		if $('input[name="beforeImage"]').length > 0
			beforeImage = $('input[name="beforeImage"]').val()
		if $('input[name="afterImage"]').length > 0
			afterImage = $('input[name="afterImage"]').val()
		data = 
			user: Meteor.userId()
			businessProfile: FlowRouter.getParam('id')
			serviceDate: $(e.currentTarget).find('input[name="serviceDate"]').val()
			serviceRating: $('#service-rating').val()
			serviceApproval: $('#service-approval').val()
			content: $(e.currentTarget).find('textarea[name="content"]').val()
			beforeImage: beforeImage
			afterImage: afterImage  
		Meteor.call('createReview', data, (err, res) -> 
			if err then Notification(err, 'error')
			if res 
				Notification('Review Submitted', 'success')
				Meteor.setTimeout(() -> 
					FlowRouter.go(FlowRouter.path('business.view',{id: FlowRouter.getParam('id')}))
				, 1500)
		)	
	'click [data-logout]': (e) ->
    e.preventDefault()
    BlockUI()
    Meteor.logoutOtherClients()
    Meteor.logout(() ->
      Meteor.setTimeout(() ->
        FlowRouter.go(FlowRouter.path('index'))
        UnblockUI()
      , 500)
    )  		
)