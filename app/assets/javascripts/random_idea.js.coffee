class RandomIdea
  URL = '/projects/random'
  constructor: (selector)->
    $('body').on 'click', "#{selector} label", ->
      $(selector).load("#{URL} .content")

$(document).on 'ready page:load', ->
  new RandomIdea('#random-idea')