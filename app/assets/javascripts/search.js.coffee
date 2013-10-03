#= require hogan.js
#= require twitter/typeahead

startSearch = ->
  $('.search-query').typeahead([
    {
      name: 'projects'
      valueKey: 'title'
      engine: Hogan
      template: "<p><strong>{{title}}</strong></p>"
      remote:
        url: '/autocomplete/projects?q=%QUERY'
    }
  ]
  ).on('typeahead:selected', (ev, selected) ->
    Turbolinks.visit("/projects/#{selected.id}")
  )

$(document).on 'ready', startSearch
$(document).on 'page:load', startSearch
