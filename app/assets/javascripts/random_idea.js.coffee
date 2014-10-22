class RandomIdea
  URL = '/projects/random'

  constructor: (selector) ->
    $(selector).click( ->
      $(selector).find('.fa-random').removeClass('fa-random').addClass('fa-spinner fa-spin')

      $(selector).load("#{URL} .content", (-> ))
    )

$(document).on 'ready page:load', ->
  new RandomIdea('#random-idea')