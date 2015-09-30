class QuickIdea
  constructor: ->
    @ui =
      submitButton: $('#create-project-button')
      titleField: $('#create-project-title')
      subtitleField: $('#create-project-subtitle')
      form: $('.quick-creation-form')
    @bindToEvents()
    @updateUI()

  canSubmit: =>
    _.any(@ui.titleField.val())

  updateUI: =>
    @ui.submitButton.toggleClass('disabled', !@canSubmit())

  bindToEvents: ->
    @ui.form.on 'submit', (ev) ->
      ev.preventDefault unless @canSubmit()
    @ui.titleField.on('change keyup', @updateUI)
    @ui.subtitleField.on('change keyup', @updateUI)

$(document).on 'page:load ready', ->
  new QuickIdea()