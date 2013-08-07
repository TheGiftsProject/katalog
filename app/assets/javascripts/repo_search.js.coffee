#= require hogan.js
#= require twitter/typeahead

startRepoSearch = ->
  $('.repo-search-query').typeahead([
    {
      name: 'repositories'
      valueKey: 'repo_url'
      engine: Hogan
      template: [
        '<p class="repo-language">{{language}}</p>',
        '<p class="repo-name">{{name}}</p>',
        '<p class="repo-description">{{description}}</p>'
      ].join('')
      prefetch:'/autocomplete/repositories.json?latest=true'
      remote:'/autocomplete/repositories.json?q=%QUERY'
    }
  ]
  ).on('typeahead:selected', (ev, selected, dataset) ->
    # update url form
  )

$(document).on 'ready', startRepoSearch
$(document).on 'page:load', startRepoSearch
