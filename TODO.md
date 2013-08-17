VALIDATIONS:
 * Project Uniqueness by repo-url + title

CREATION FORM:
 * when choosing URL the name and desc should auto upadte the other fields
 * move repo url to top
 * disable form submtion when choosing url with ENTER
 * after creation the redirect is blank although the project is created (check erros)

POST:
   * Default code format recognition in the server.
   * Emoji autocomplete.
   * Edit post.
   * MD preview should be the same preview as the final result (maybe by server request?).

ACTIVITY FEED:
   * Should be the default page. Should have a 'pill' at the top of the index page as well.
   * Create a page with recent posts / new projects.

ZEN PAGE:
   * Do not limit to 5. More randomness. Titles!

GENERAL UI:
   * Prevent from posting new posts or submitting project if empty fields (title/subtitle/post itself) by disabling button.

ProjectsController Filter Methods:
  * Move filters methods from ProjectsController to support class
