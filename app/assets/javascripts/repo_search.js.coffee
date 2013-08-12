#= require hogan.js
#= require twitter/typeahead

startRepoSearch = ->

  filterResponse = (parsedResponse)->
    _.each(parsedResponse, (repo)->
      # aid typeahead.js in matching data with a given query.
      repo.tokens = _.compact(repo.name.split(/[_-]/))
    )
    parsedResponse

  repoTemplate = [
    '<p class="repo-language">{{language}}</p>',
    '<p class="repo-name">{{name}}</p>',
    '<p class="repo-description">{{description}}</p>'
  ].join('')

  $('#project_repo_url').typeahead([
    {
      name: 'repositories'
      valueKey: 'repo_url'
      limit: 4
      engine: Hogan
      template: repoTemplate
      prefetch:
        url: '/autocomplete/repositories.json?latest=true'
        filter: filterResponse
      remote:
        url: '/autocomplete/repositories.json?q=%QUERY'
        filter: filterResponse
    }
  ])

$(document).on 'ready', startRepoSearch
$(document).on 'page:load', startRepoSearch
