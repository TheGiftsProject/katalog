init = ->
  button = $('.upload-image')
  parentEl = button.parent()
  submitForm = parentEl.find('form')
  submitFormInput = submitForm.find('#project_image_url')
  inputEl = parentEl.find('.file-field')

  button.on('click', -> inputEl.click())
  inputEl.fileupload(
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

    add: (e, data) ->
      parentEl.addClass('syncing')
      data.submit()

    done: (e, data) ->
      fileUrl = data.result.getElementsByTagName('Location')[0].firstChild.nodeValue
      submitFormInput.val(fileUrl)
      submitForm.submit()

    always: (e, data) ->
      parentEl.removeClass('syncing')
  )

$(document).on 'ready page:load', init