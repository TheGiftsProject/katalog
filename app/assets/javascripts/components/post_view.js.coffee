class window.PostView

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

    @ui.markdownText.fileupload(
      dropZone: @ui.markdownText
      url: 'https://s3.amazonaws.com/katalog-images/'
      type: 'POST'
      autoUpload: true
      dataType: 'xml'
      paramName: 'file'
      formData: -> # this method is binded to fileupload component and must not be binded to this class
        data = S3Storage.generateFormData()
        fileType = if 'type' of @files[0] then @files[0].type else ''
        data.push(name: 'Content-Type', value: fileType)
        data
    )

  _bindEvents: ->
    _.bindAll(@, '_onChange', '_uploadCompleted', '_fileAdded')
    @ui.markdownText.bind('fileuploadadd', @_fileAdded)
    @ui.markdownText.bind('fileuploaddone', @_uploadCompleted)
    @ui.markdownText.change(@_onChange)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)

  _fileAdded: (ev, data) ->
    console.log 'file added'
    console.log data

  _uploadCompleted: (ev, data) ->
    file = data.result.getElementsByTagName('Location')[0].firstChild.nodeValue
    text = @ui.markdownText.val()
    text += "![](#{file})"
    @ui.markdownText.val(text)
    @ui.markdownText.change()

$(document).on 'ready', PostView.registerViews
$(document).on 'page:load', PostView.registerViews




