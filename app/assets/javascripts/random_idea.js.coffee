class RandomIdea
  URL = '/projects/random'
  INTERVAL = 15 * 1000

  constructor: (selector) ->
    @element = $(selector)
    @element.click(=>
      clearInterval(@intervalId)
      @loadRandomIdea()
      @setReloadingInInterval()
    )

    @setReloadingInInterval()

  setReloadingInInterval: ->
    @intervalId = setInterval((=> @loadRandomIdea()), INTERVAL)

  loadRandomIdea: ->
    @element.find('.fa-random').removeClass('fa-random').addClass('fa-spinner fa-spin')
    @element.load("#{URL} .content")

$(document).on 'ready page:load', ->
  new RandomIdea('#random-idea')