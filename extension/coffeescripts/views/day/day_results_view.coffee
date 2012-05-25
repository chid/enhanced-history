class BH.Views.DayResultsView extends Backbone.View
  templateId: 'day_results'

  events:
    'click .delete_visit': 'deleteVisitClicked'
    'click .delete_interval': 'deleteIntervalClicked'

  render: ->
    @$el.html(@template(_.extend(i18n.day(), @collection.toTemplate())))

  deleteIntervalClicked: (ev) ->
    ev.preventDefault()
    element = @_getTopElement(ev.currentTarget)
    @collection.get($(element).data('id')).get('pageVisits').destroyAll
      success: =>
        @removeElement(element)

  deleteVisitClicked: (ev) ->
    ev.preventDefault()
    element = @_getTopElement(ev.currentTarget)
    @collection.findVisitById($(element).data('id')).destroy
      success: =>
        @removeElement(element)

  removeElement: (element)->
    element.slideUp 'fast', ->
      element.remove()

  _getTopElement: (element) ->
    $(element).parents('[data-id]').first()
