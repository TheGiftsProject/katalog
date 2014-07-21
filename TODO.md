__FEATURES:__
 * Collapsable onboarding with invites.
 
__SANITY CHECKS:__
 * Sweep code base and remove old stuff (JS, Css, controllers, concerns, models, helpers, models).
 * n+1 checks (e.g. likes).
 * Add authorization for everything related to project controller (don't allow edit if not contributor etc).
 * Check organizations/projects/users scopes throughout controllers and support.
 * Error pages work? (also when not in organization scope - 404, rescue from record not found). I18n for errors.
 * What happens when Github organization is deleted? Merge users organization with existing one (only when changing organization).
 * Make sure postmark works again after production.
 
__NICE TO HAVE:__
 * Specs - add for basic control flows.
 * Edit posts.
 * Paper plane 3d.
 * Emoji autocomplete in posts and fixes in preview mode ('dancer' works, '+1' doesn't).
 * Github activity and project-neggers.