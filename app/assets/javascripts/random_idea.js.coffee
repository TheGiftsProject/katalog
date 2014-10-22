class RandomIdea
  URL = '/projects/random'
  INTERVAL = 15 * 1000

  constructor: (selector) ->
    @element = $(selector)
    @addClickEvent()

    @setReloadingInInterval()

  addClickEvent: ->
    @element.find('.random-title').click(=>
      clearInterval(@intervalId)
      @loadRandomIdea()
      @setReloadingInInterval()
    )

  setReloadingInInterval: ->
    @intervalId = setInterval((=> @loadRandomIdea()), INTERVAL)

  loadRandomIdea: ->
    @element.find('.fa-random').removeClass('fa-random').addClass('fa-spinner fa-spin')
    @element.load("#{URL} .content", => @addClickEvent())

$(document).on 'ready page:load', ->
  new RandomIdea('#random-idea')