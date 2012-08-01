class BH.Views.Modal extends BH.Views.BaseView
  pulseClass: 'pulse'

  generalEvents:
    'click .close-button': 'close'
    'click .overlay': 'pulse'

  attachGeneralEvents: ->
    _.extend(@events, @generalEvents)

  renderTemplate: (json) ->
    overlay = $(BH.Templates['modal'])
    $('.page', overlay).append(Mustache.to_html(@template, json))
    overlay

  open: ->
    $('body').append(@render().el)
    @_globalBinds()
    $(window).trigger('resize')
    setTimeout( ->
      @$('.overlay').removeClass('transparent')
    , 0)

  pulse: ->
    @$('.page').addClass('pulse')

  close: ->
    @trigger('close')
    @$('.overlay').addClass('transparent')
    setTimeout( =>
      @remove()
    , 1000)
    @_globalUnbinds()

  _globalBinds: ->
    $(window).resize(@_updateHeight)
    $(window).keydown($.proxy(@_closeOnEscape, @))

  _globalUnbinds: ->
    $(window).unbind('resize')
    $(document).unbind('keydown')

  _updateHeight: ->
    @$('.page').css
      maxHeight: Math.min(0.9 * window.innerHeight, 640)

  _closeOnEscape: (e) ->
    if e.keyCode == 27
      @close()