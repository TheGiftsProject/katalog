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
      url: S3Storage.bucketUrl
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
    @ui.markdownText.insertAtCaret(@_placeholderForFile(data.files[0].name))

  _uploadCompleted: (ev, data) ->
    file = data.result.getElementsByTagName('Location')[0].firstChild.nodeValue
    text = @ui.markdownText.val()
    originalFilename = data.files[0].name
    text = text.replace(@_placeholderForFile(originalFilename), @_markdownForImage(file, originalFilename))
    @ui.markdownText.val(text)
    @ui.markdownText.change()

  _placeholderForFile: (filename) ->
    "![Uploading #{filename} ...]()"

  _markdownForImage: (file, originalFilename) ->
    "![#{originalFilename}](#{file})"

$(document).on 'ready', PostView.registerViews
$(document).on 'page:load', PostView.registerViews




