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
      fileUploadForm: @$el.find('#file-upload-form')
    @ui.fileUploadForm.S3Uploader()

  _bindEvents: ->
    _.bindAll(@, '_onChange', '_uploadCompleted')
    @ui.markdownText.change(@_onChange)
    @ui.fileUploadForm.bind('s3_upload_complete', @_uploadCompleted)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)

  _uploadCompleted: (ev, content) ->
    text = @ui.markdownText.val()
    text += "![Alt text](#{content.url})"
    @ui.markdownText.val(text)
    @ui.markdownText.change()

$(document).ready(->
  new PostView(el: $('.post'))
)




