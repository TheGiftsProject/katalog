class UserSync

  constructor: (selector) ->
    @collapseButtons = $("#{selector} .collapse-btn")
    @panels = $("#{selector} .panel")
    @collapsePanelsIfNeededAtStart()

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
    index = $('.panel.project-list').index(panel)
    cookie = "panel-collapsed-#{index}"
    if collapse
      panel.addClass('collapsed')
      $.cookie(cookie, true, {expires: 1})
    else
      panel.removeClass('collapsed').removeClass('no-transition')
      $.removeCookie(cookie)

  collapsePanelsIfNeededAtStart: ->
    @panels.each((index, el) =>
      cookie = "panel-collapsed-#{index}"
      if $.cookie(cookie)
        $(el).addClass('no-transition')
        @collapseOrNot($(el), true)
        @replaceButton($(el).parent().find('.fa-caret-up'), true)
    )


$(document).on 'ready page:load', ->
  new UserSync('.user-sync')