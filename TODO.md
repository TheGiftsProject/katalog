BUGS:
 * Last commit does not update a project (Github hooks problem?).
 * Tags autocomplete in project form has a UI weirdness.
  
PROJECT PAGE:
 * Allow to change status not only with post. 
 * Allow to change image not only by post.
 * Add project name to title **Hubot @ Katalog**
 * Add a nice page like UI for github pages (readme, todo ...). Currently their transition is too violent and the backround is wrong.
 * Don't show icons of TODO/Readme etc if not exist.

CREATION FORM:
 * Disable form submtion when choosing url with ENTER.
 * Disable submiting (create/edit) a project when not all fields are filled/validated.

POST:
   * Default code format recognition in the server.
   * Emoji autocomplete.
   * MD preview should be the same preview as the final result (maybe by server request?).
   * Edit post.

ZEN PAGE:
   * Better. More random? Only recent? With people? UGH.

INTERNALS:
 * Check https://github.com/josevalim/inherited_resources or build generic helper
 * Move filters methods from ProjectsController to support class
