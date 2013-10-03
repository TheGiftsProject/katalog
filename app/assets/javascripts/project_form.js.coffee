projectFormValidation = ->

  ui =
    submitButton: $('.project-form #project-submit-button')
    titleField: $('.project-form #project_title')
    subtitleField: $('.project-form #project_subtitle')
    postField: $('.project-form #project_posts_attributes__text')

  checkIfCanSubmit = ->
    canSubmit = _.any(ui.titleField.val()) && _.any(ui.subtitleField.val()) && (ui.postField.length == 0 || _.any(ui.postField.val()))
    ui.submitButton.addClass('disabled') unless canSubmit
    canSubmit

  checkIfCanSubmit()

  $('.project-form').on('keypress keydown keyup', (e) ->
    e.preventDefault() if e.keyCode == 13 && !checkIfCanSubmit()
  )

$(document).on 'ready', projectFormValidation
$(document).on 'page:load', projectFormValidation
