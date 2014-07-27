__TODO:__
 * Upgrade Rails.
 * Github activity (shay).

__BUGS:__
 * User search doesn't work? - Yon: There's some caching issues - it's cached per day 
 
__SANITY CHECKS:__
 * Controllers code cleanup.
 * CSS cleanup.
 * n+1 fixes. complete mess there.
 * Add authorization for everything related to project controller (make sure everything is scoped to your org).
 * Check organizations/projects/users scopes throughout controllers and support.
 * Error pages work? (also when not in organization scope - 404, rescue from record not found). I18n for errors.
 * What happens when Github organization is deleted? Merge users organization with existing one (only when changing organization).
 * Make sure postmark works again after production.
 
__VERSION 1.6__
 * Collapsable onboarding with invites.
 * Specs - add for basic control flows.
 * Edit posts.
 * Emoji autocomplete in posts and fixes in preview mode ('dancer' works, '+1' doesn't).
