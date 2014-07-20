__FEATURES:__
 * Collapsable onboarding with invites.
 * Make the same project in random project when liking from random
 
__SANITY CHECKS:__
 * Move assets from public to app.
 * Don't load javascripts in root.
 * n+1 checks (e.g. likes).
 * Add authorization for everything related to project controller (don't allow edit if not contributor etc).
 * Check organization scopes (search for users, projects, all syncing stuff, validations and controller actions).
 * Error pages work (also when not in organization scope). I18n for errors.
 * Specs - add for basic control flows.
 * What happens when organization is deleted? Merge users organization with existing one (only when changing organization).
 * Sweep code base and remove old stuff (JS, Css, controllers, concerns, models, helpers, models, 
 * Make sure postmark works again after production.
 
__NICE TO HAVE:__
 * Edit posts.
 * Paper plane 3d.
 * Emoji autocomplete in posts and fixes in preview mode ('dancer' works, '+1' doesn't).
 * Github activity and project-neggers.