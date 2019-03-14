Template.onRendered(() ->
  $('select.select2').each((i) ->
    opts = {}
    $this = $(@)
    if $this.data('placeholder')? then opts.placeholder = $this.data('placeholder')
    if $this.data('allow-clear')? then opts.allowClear = $this.data('allow-clear')
    if $this.data('source')? then opts.data = $this.data('source')
    if $this.data('max-selected-options')? then opts.data = $this.data('max-selected-options')
    if $this.data('search-enabled')?
      if $this.data('search-enabled') then opts.minimumResultsForSearch = 1
      else opts.minimumResultsForSearch = Infinity
    if $this.data('tags-enabled')
      opts.tags = $this.data('tags-enabled')
      opts.tokenSeparators = [',']
    $this
      .select2(opts)
      .on('change', () ->
        if $.trim($(this).val().length) != 0 
          $(this).siblings('.select2-container').find('.select2-selection--single').removeClass('required-form')
          $(this).siblings('.select2-container').find('.select2-selection--multiple').removeClass('required-form')
          $(this).siblings('.error-message').text('')
      )
  )

  popUpOptions =
    exclusive:true
    preserve:true
    lastResort: 'bottom center'
    hoverable: true

  $('[data-popup][data-popup-inline]').popup(_.extend(popUpOptions,{inline:true}))
  $('[data-popup]').popup(popUpOptions)

  $('.ui.checkbox,.ui.radio.checkbox').checkbox()

  $('body, .main-container').scroll(() -> 
    $('input').blur()

    if FlowRouter.current().route.name == 'app.profile'
      $("#neighborhood, #state, #serviceLocations, #serviceGroup, #specialties").select2('close')
  )

  if FlowRouter.current().route.name == 'share'
    Session.set('business_id', FlowRouter.getParam('id'))

  $('input, textarea').on('keypress', () ->
    $(this).removeClass('required-form')
    $(this).siblings('.error-message').text('')
  )

  $('#phoneNumber').inputmask({"mask": "(999) 999-9999"})
)