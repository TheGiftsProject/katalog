emojiExtension = (converter) ->
    [
      {
        type    : 'lang',
        regex   : '\\B:([\\S]+):',
        replace : (match, prefix, content, suffix) ->
              return "<img src='/assets/emojis/#{prefix}.png' height=20 width=20/>"
      }
    ]

class window.PostView

  @registerViews: ->
    $('.post').each(-> new PostView(el: $(this)))

  constructor: (options) ->
    @$el = options.el
    @converter = new Showdown.converter(extensions: [emojiExtension])
    @_initUI()
    @_bindEvents()

  _initUI: ->
    @ui =
      markdownText: @$el.find('.markdown-text')
      markdownPreview: @$el.find('.markdown-preview')
      fileUploadForm: @$el.find('#file-upload-form')
      statusUpdateCheckbox: @$el.find('.checkbox.update')
      changeStatusRadio: @$el.find('.radio-group')
    @ui.fileUploadForm.S3Uploader()

  _bindEvents: ->
    _.bindAll(@, '_onChange', '_uploadCompleted','_statusUpdateChange')
    @ui.markdownText.change(@_onChange)
    @ui.fileUploadForm.bind('s3_upload_complete', @_uploadCompleted)
    @ui.statusUpdateCheckbox.change(@_statusUpdateChange)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)

  _uploadCompleted: (ev, content) ->
    text = @ui.markdownText.val()
    text += "![Alt text](#{content.url})"
    @ui.markdownText.val(text)
    @ui.markdownText.change()

  _statusUpdateChange: ->
    @ui.changeStatusRadio.toggle()

$(document).on 'ready', PostView.registerViews
$(document).on 'page:load', PostView.registerViews




