class window.PostView

  @formDataFields: {}

  @registerViews: ->
    $('.post').each(-> new PostView(el: $(this)))

  constructor: (options) ->
    @$el = options.el
    @converter = new Showdown.converter()
    @_initUI()
    @_bindEvents()

  _initUI: ->
    @ui =
      markdownText: @$el.find('.markdown-text')
      markdownPreview: @$el.find('.markdown-preview')
    @ui.markdownText.dropzone(url: 'https://s3.amazonaws.com/katalog-images/', sending: (file, xhr, formData) => @_beforeUpload(file, xhr, formData))

  _bindEvents: ->
    _.bindAll(@, '_onChange', '_uploadCompleted')
    @ui.markdownText.change(@_onChange)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)

  _beforeUpload: (file, xhr, formData) ->
    xhr.setRequestHeader('Accept', '*/*')

    for key of @constructor.formDataFields
      formData.append(key, @constructor.formDataFields[key])

  _uploadCompleted: (ev, content) ->
    text = @ui.markdownText.val()
    text += "![Alt text](#{content.url})"
    @ui.markdownText.val(text)
    @ui.markdownText.change()

$(document).on 'ready', PostView.registerViews
$(document).on 'page:load', PostView.registerViews




