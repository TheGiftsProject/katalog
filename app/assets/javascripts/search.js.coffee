#= require twitter/typeahead

startSearch = ->
  window.el = $('.search-query')
  projects = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: '/autocomplete/projects?q=%QUERY'
  )
  projects.initialize()

  users = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch:
      url: "/autocomplete/users.json?#{new Date().getDate()}"
  )
  users.initialize()

  $('.search-query').typeahead(
    {
      hint: true,
      highlight: true,
      minLength: 1,
    },
    {
      name: 'projects'
      displayKey: 'title'
      source: projects.ttAdapter()
    },
    {
      name: 'users'
      displayKey: 'name'
      source: users.ttAdapter()
      templates:
        suggestion: (user) -> "<p><img class='avatar tiny' src='#{user.image}'></img>  @#{user.name}</p>"
    }
  ).on('typeahead:selected', (ev, selected) ->
    Turbolinks.visit(selected.url)
  )

$(document).on 'ready page:load', startSearch