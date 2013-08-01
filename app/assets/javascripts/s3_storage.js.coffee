class window.S3Storage

  @formFields: null
  @bucketUrl: null

  @generateFormData: ->
    data = []
    for key of @formFields
      data.push(name: key, value: @formFields[key])
    data[1].value = data[1].value.replace('{timestamp}', new Date().getTime())

    data