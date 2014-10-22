class UserSync

  constructor: (selector) ->
    @collapseButtons = $("#{selector} .collapse-btn")

    @collapseButtons.click((ev) =>
      button = $(ev.target)
      panel = $(ev.target).parent().parent().parent().find('.panel')
      collapse = button.hasClass('fa-caret-up')
      @replaceButton(button, collapse)
      @collapseOrNot(panel, collapse)
    )

  replaceButton: (btn, collapse) ->
    if collapse
      btn.removeClass('fa-caret-up').addClass('fa-caret-down')
    else
      btn.removeClass('fa-caret-down').addClass('fa-caret-up')

  collapseOrNot: (panel, collapse) ->
    if collapse
      panel.addClass('collapsed')
    else
      panel.removeClass('collapsed')

$(document).on 'ready page:load', ->
  new UserSync('.user-sync')