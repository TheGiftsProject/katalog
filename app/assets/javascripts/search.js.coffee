#= require twitter/typeahead

startSearch = ->
  window.el = $('.search-query')
  projects = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: '/autocomplete/projects?q=%QUERY'
  )
  projects.initialize()

  $('.search-query').typeahead(
    {
#      hint: true,
      highlight: true,
      minLength: 1,
    },
    {
      name: 'projects'
      displayKey: 'title'
      valueKey: 'url'
      source: projects.ttAdapter()
    }
  ).on('typeahead:selected', (ev, selected) ->
    Turbolinks.visit(selected.url)
  )

$(document).on 'ready page:load', startSearch