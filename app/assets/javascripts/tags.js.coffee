#= require hogan.js
#= require twitter/typeahead

template = Hogan.compile(" <a href='#'><span class='tag'><input type='hidden' name='project[string_tags][]' value='{{value}}'/>{{name}} <i class='icon-remove'/></span></a>")

ui = {}

addTag = (tag) ->
  addTagString(tag.name)

addTagString = (tagString)->
  ui.tags.append(template.render(name: tagString, value: tagString))
  ui.input.val('')

startTags = ->
  ui.tags = $('.tags')
  ui.tagging = $('.tagging')
  ui.input = $('#tags_input')

  ui.tagging.on 'click', (ev,el) ->
    target = $(ev.target)
    if target.is('a')
      ev.preventDefault()
      target.remove()
    else if target.parents('a').length > 0
      ev.preventDefault()
      target.parents('a').remove()

  ui.input.typeahead(
    name: 'prefetched_tags'
    prefetch:
      url: '/autocomplete/tags.json'
      ttl: 500
    valueKey: 'name'
    engine: Hogan
    template: "<p><span class='tag'>{{name}}</span></p>"
  ).on('typeahead:selected', (ev, selected, dataset) ->
    addTag(selected);
  ).on('keypress', (ev) ->
    if ev.which == 13
      ev.preventDefault()
      addTagString($(ev.target).val());

  )

$(document).on 'ready', startTags
$(document).on 'page:load', startTags
