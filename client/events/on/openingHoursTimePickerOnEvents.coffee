Template.openingHoursTimePicker.onRendered(() ->
	$('.start-time').on('change', () ->
		day = $(this).data('day')
		val = $(this).val()

		$('#' + day + '-end-time').timepicker(
			minTime: val
		)
	)

	$('.end-time').on('change', () -> 
		day = $(this).data('day')
		val = $(this).val()

		$('#' + day + '-start-time').timepicker(
			maxTime: val
		)
	)
)