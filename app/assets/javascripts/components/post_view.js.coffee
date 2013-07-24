class window.PostView

  constructor: (options) ->
    @$el = options.el
    @converter = new Showdown.converter()
    @ui =
      markdownText: @$el.find('.markdown-text')
      markdownPreview: @$el.find('.markdown-preview')

    @_bindEvents()

  _bindEvents: ->
    _.bindAll(@, '_onChange')
    @ui.markdownText.keyup(@_onChange)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)






