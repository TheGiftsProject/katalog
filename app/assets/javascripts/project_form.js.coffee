projectFormValidation = ->

  ui =
    submitButton: $('form #project-submit-button')
    titleField: $('form #project_title')
    subtitleField: $('form #project_subtitle')
    postField: $('form #project_posts_attributes__text')

  canSubmit = ->
    _.any(ui.titleField.val()) && _.any(ui.subtitleField.val()) && (ui.postField.length == 0 || _.any(ui.postField.val()))

  ui.submitButton.addClass('disabled') unless canSubmit()



$(document).on 'ready', projectFormValidation
$(document).on 'page:load', projectFormValidation
