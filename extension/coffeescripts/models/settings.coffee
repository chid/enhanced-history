class BH.Models.Settings extends BH.Models.Base
  storeName: 'settings'

  defaults: ->
    {
      timeGrouping: 15
      domainGrouping: true
      timeFormat: parseInt(@chromeAPI.i18n.getMessage('default_time_format'), 10)
      searchByDomain: true
      searchBySelection: true
    }

  toTemplate: ->
    timeGrouping: [
      {
        text: @chromeAPI.i18n.getMessage('15_minutes_option')
        value: 15
        selected: @_timeGroupingSelectedCheck(15)
      },
      {
        text: @chromeAPI.i18n.getMessage('30_minutes_option')
        value: 30
        selected: @_timeGroupingSelectedCheck(30)
      },
      {
        text: @chromeAPI.i18n.getMessage('60_minutes_option')
        value: 60
        selected: @_timeGroupingSelectedCheck(60)
      }
    ]
    timeFormats: [
      {
        text: @chromeAPI.i18n.getMessage('12_hours_option')
        value: 12
        selected: @_timeFormatSelectedCheck(12)
      },
      {
        text: @chromeAPI.i18n.getMessage('24_hours_option')
        value: 24
        selected: @_timeFormatSelectedCheck(24)
      }
    ]
    searchBySelection: @get('searchBySelection')
    searchByDomain: @get('searchByDomain')
    domainGrouping: @get('domainGrouping')
    version: version.get('version')

  timeGrouping: ->
    parseInt(@get('timeGrouping'), 10)

  timeFormat: ->
    parseInt(@get('timeFormat'), 10)

  parse: (data) ->
    @set(JSON.parse(data))

  _timeGroupingSelectedCheck: (value) ->
    if parseInt(value, 10) == @timeGrouping() then true else false

  _timeFormatSelectedCheck: (value) ->
    if parseInt(value, 10) == @timeFormat() then true else false