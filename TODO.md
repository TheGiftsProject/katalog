SUPER IMPORTANT P1 ISSUE:
 * Users are being added through adam's github thingie which gives them access to view Katalog.

__PIPELINE:__
 * Fix long contributors list (limit to 3-4 and limit title).
 * Autocomplete should find users as well.
 * Add "did you start working on it already?" after creating a project.

GITHUB BUGS:
 * Last commit does not update a project (Github hooks problem?).
 * Updating repo doesn't update committers as contributors (works on creation).
 * Currently invalid repos (for users outside the organization) makes the Github syncer throw exceptions. They are rescued and nothing happens.

PROJECT PAGE:
 * Allow to change status not only with post.
 * Allow to change image not only by post.
 * Add project name to title **Hubot @ Katalog**
 * Hey "X", what's up with project X? (if no update for a 2-weeks?).
 * Display last commit update date on project page - if a page is bumped because of a commit I don't see it

TODO/README/CHANGELOG PAGES:
 * Don't show icons of TODO/Readme etc if not exist.
 * Add a nice page like UI for github pages (readme, todo ...). Currently their transition is too violent and the backround is wrong.
 * `Back` link should redirect to project page, not to `All projects`.
 * Link to github view

POST:
   * Default code format recognition in the server.
   * Emoji autocomplete.
   * MD preview should be the same preview as the final result (maybe by server request?).
   * Edit post.
   * 
Nice To Have:
  * Add a feedback tab that redirect people to - https://github.com/TheGiftsProject/katalog/edit/master/TODO.md
  * Add the image of the project to the table view

