__ADI FEEDBACK:__
 * Random idea refresh button should look like a button (make the left icon button like).

__BUGS:__
 * Image upload to post now uploads to entire project, which refreshes page and doesnt allow you to post images...
 
__SANITY CHECKS:__
 * Controllers code cleanup.
 * CSS cleanup.
 * n+1 fixes. complete mess there.
 * Add authorization for everything related to project controller (don't allow edit if not contributor etc).
 * Check organizations/projects/users scopes throughout controllers and support.
 * Error pages work? (also when not in organization scope - 404, rescue from record not found). I18n for errors.
 * What happens when Github organization is deleted? Merge users organization with existing one (only when changing organization).
 * Make sure postmark works again after production.
 
__VERSION 1.6__
 * Collapsable onboarding with invites.
 * Specs - add for basic control flows.
 * Edit posts.
 * Emoji autocomplete in posts and fixes in preview mode ('dancer' works, '+1' doesn't).
 * Github activity and project-neggers.