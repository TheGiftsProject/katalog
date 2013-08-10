#= require hogan.js
#= require twitter/typeahead

startRepoSearch = ->

  filterResponse = (parsedResponse)->
    maxDescLength = 43
    _.each(parsedResponse, (repo)->
      repo.tokens = [repo.name]
      if repo.description?.length > maxDescLength
        repo.description = repo.description.substring(0, maxDescLength) + '...'
    )
    parsedResponse

  $('#project_repo_url').typeahead([
    {
      name: 'repositories'
      valueKey: 'repo_url'
      engine: Hogan
      template: [
        '<p class="repo-language">{{language}}</p>',
        '<p class="repo-name">{{name}}</p>',
        '<p class="repo-description">{{description}}</p>'
      ].join('')
      prefetch:
        url: '/autocomplete/repositories.json?latest=true'
        filter: filterResponse
      remote:
        url: '/autocomplete/repositories.json?q=%QUERY'
        filter: filterResponse
    }
  ]
  ).on('typeahead:selected', (ev, selected, dataset) ->
    # update url form
  )

$(document).on 'ready', startRepoSearch
$(document).on 'page:load', startRepoSearch
