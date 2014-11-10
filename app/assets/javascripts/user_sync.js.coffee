class UserSync

  constructor: (selector) ->
    @ui =
      collapseButtons: $("#{selector} .collapse-btn")
      panels: $("#{selector} .panel")

    @collapsePanelsIfNeededAtStart()
    @bindToEvents()

  bindToEvents: ->
    @ui.collapseButtons.click((ev) =>
      button = $(ev.target)
      panel = $(ev.target).parent().parent().parent().find('.panel')
      collapse = button.hasClass('fa-caret-up')
      @collapse(panel, collapse)
    )

  collapsePanelsIfNeededAtStart: ->
    @ui.panels.each (index, el) =>
      if $.cookie(@cookieNameForIndex(index))
        $(el).addClass('no-transition')
        @collapse($(el), true)

  collapse: (panel, collapse) ->
    button = $(panel).parent().find('.collapse-btn')
    @replaceButton(button, collapse)
    @modifyPanel(panel, collapse)

  replaceButton: (btn, collapse) ->
    if collapse
      btn.removeClass('fa-caret-up').addClass('fa-caret-down')
    else
      btn.removeClass('fa-caret-down').addClass('fa-caret-up')

  modifyPanel: (panel, collapse) ->
    index = $('.panel.project-list').index(panel)
    cookie = @cookieNameForIndex(index)
    if collapse
      panel.addClass('collapsed')
      $.cookie(cookie, true, {expires: 1})
    else
      panel.removeClass('collapsed').removeClass('no-transition')
      $.removeCookie(cookie)

  cookieNameForIndex: (index) ->
    "panel-collapsed-#{index}"

$(document).on 'ready page:load', ->
  new UserSync('.user-sync')