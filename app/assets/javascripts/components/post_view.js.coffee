class window.PostView

  constructor: (options) ->
    @$el = options.el
    @converter = new Showdown.converter()
    @_initUI()
    @_bindEvents()

  _initUI: ->
    @ui =
      markdownText: @$el.find('.markdown-text')
      markdownPreview: @$el.find('.markdown-preview')
    @$el.S3Uploader()

  _bindEvents: ->
    _.bindAll(@, '_onChange', '_uploadCompleted')
    @ui.markdownText.keyup(@_onChange)
    @$el.bind('s3_upload_complete', @_uploadCompleted)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)

  _uploadCompleted: (ev, content) ->
    console.log "file uploaded to: #{content.url}"






