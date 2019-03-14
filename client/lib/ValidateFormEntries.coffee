@ValidateFormEntries = ($form) ->
	$form.find('input, select, textarea').each((e) ->
		if $(this).hasClass('required')
			if $.trim($(this).val()).length == 0
				if $(this).hasClass('select2')
					$(this).siblings('.select2-container').find('.select2-selection--single').addClass('required-form')
					$(this).siblings('.select2-container').find('.select2-selection--multiple').addClass('required-form')
				else		
					$(this).addClass('required-form')

				$(this).siblings('.error-message').text($(this).attr('placeholder')+ ' is required.')
			
			$('.main-container').on("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", () ->
      			$('.main-container').stop(true, true)
    		)

			$('.main-container').animate({ scrollTop: $form.position().top * 20 }, 'slow', () ->
      			$('.main-container').off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove")
    		)	
	)