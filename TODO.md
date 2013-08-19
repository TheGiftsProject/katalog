BUGS:
 * Fix create project with repo failure.
 * Don't show icons of TODO/Readme etc if not exist.
 * Last commit does not update our project.
 * TODO/Readme etc transition is too violent. It also changes the background which it shouldn't.
 * Repo url input field background is buggy.
 * Tags autocomplete in project form has a UI weirdness.

MODEL CONCERN HELPERS
 * check https://github.com/josevalim/inherited_resources
 * or build generic helper

CREATION FORM:
 * Disable form submtion when choosing url with ENTER

POST:
   * Default code format recognition in the server.
   * Emoji autocomplete.
   * Edit post.
   * MD preview should be the same preview as the final result (maybe by server request?).

ZEN PAGE:
   * Do not limit to 5. More randomness. Titles!

GENERAL UI:
   * Prevent from posting new posts or submitting project if empty fields (title/subtitle/post itself) by disabling button.

ProjectsController Filter Methods:
  * Move filters methods from ProjectsController to support class
