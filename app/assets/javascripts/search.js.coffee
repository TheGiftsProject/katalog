#= require hogan.js
#= require twitter/typeahead

startSearch = ->
  $('.search-query').typeahead([
    {
      name: 'prefetched_tags'
      prefetch:
        url: '/autocomplete/tags.json'
        ttl: 500
      valueKey: 'name'
      engine: Hogan
      template: "<p><span class='tag'>{{name}}</span></p>"
    }
    {
      name: 'projects'
      valueKey: 'title'
      engine: Hogan
      template: "<p><strong>{{title}}</strong></p>"
      remote:
        url: '/autocomplete/projects?q=%QUERY'
    }
  ]
  ).on('typeahead:selected', (ev, selected, dataset) ->
    if selected.title
      path = "/projects/#{selected.id}"
    else
      path = "/projects?tag=#{selected.name}"
    Turbolinks.visit(path)
  )

$(document).on 'ready', startSearch
$(document).on 'page:load', startSearch
