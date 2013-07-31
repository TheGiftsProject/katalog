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

    formDataFields = @constructor.formDataFields
    @ui.markdownText.fileupload(
      dropZone: @ui.markdownText
      url: 'https://s3.amazonaws.com/katalog-images/'
      type: 'POST'
      autoUpload: true
      dataType: 'xml'
      paramName: 'file'
      formData: (form) ->
        data = $('#file-upload-form').serializeArray()
#        for key of formDataFields
#          data.push(name: key, value: formDataFields[key])

        key = data[1].value.replace('{timestamp}', new Date().getTime()).replace('{unique_id}', @files[0].unique_id)
        data[1].value = key

        fileType = ''
        if 'type' of @files[0]
          fileType = @files[0].type
        data.push(name: 'content-type', value: fileType)

        data
    )

    $(document).bind('dragover', -> null)
    $(document).bind('drop dragover', (event) -> event.preventDefault())

  _bindEvents: ->
    _.bindAll(@, '_onChange', '_uploadCompleted')
    @ui.markdownText.change(@_onChange)

  _onChange: ->
    text = @ui.markdownText.val()
    html = @converter.makeHtml(text)
    @ui.markdownPreview.html(html)

  _uploadCompleted: (ev, content) ->
    text = @ui.markdownText.val()
    text += "![Alt text](#{content.url})"
    @ui.markdownText.val(text)
    @ui.markdownText.change()

$(document).on 'ready', PostView.registerViews
$(document).on 'page:load', PostView.registerViews




