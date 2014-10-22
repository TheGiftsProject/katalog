class UserSync

  constructor: (selector) ->
    @collapseButtons = $("#{selector} .collapse-btn")

    @collapseButtons.click((ev) =>
      button = $(ev.target)
      row = $(ev.target).parent().parent()
      panel = row.parent().find('.panel')
      collapse = button.hasClass('fa-caret-up')
      @replaceButton(button, collapse)
      @collapseOrNot(panel, row, collapse)
    )

  replaceButton: (btn, collapse) ->
    if collapse
      btn.removeClass('fa-caret-up').addClass('fa-caret-down')
    else
      btn.removeClass('fa-caret-down').addClass('fa-caret-up')

  collapseOrNot: (panel, row, collapse) ->
    if collapse
      panel.slideUp()
      row.addClass('collapsed')
    else
      panel.slideDown()
      row.removeClass('collapsed')

$(document).on 'ready page:load', ->
  new UserSync('.user-sync')