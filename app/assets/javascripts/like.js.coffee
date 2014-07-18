class LikeButton
  URL = -> "/projects/#{window.currentProjectId}/like"

  constructor: (selector) ->
    el = $(selector)
    text = el.find('span')
    icon = el.find('.fa')
    el.click ->
      $.post(URL())
      if icon.hasClass('fa-thumbs-o-up')
        text.text('Unlike')
        icon.removeClass('fa-thumbs-o-up')
        icon.addClass('fa-thumbs-o-down')
        el.removeClass('btn-success')
        el.addClass('btn-danger')
      else
        text.text('Like')
        icon.addClass('fa-thumbs-o-up')
        icon.removeClass('fa-thumbs-o-down')
        el.removeClass('btn-danger')
        el.addClass('btn-success')

$(document).on 'ready page:load', ->
  new LikeButton('.like-button')

