__FEATURES:__
 * I'm a collaborator.
 * Collapsable onboarding with invites.
 * Prevent creation until title and subtitles are present.
 
__SANITY CHECKS:__
 * Don't load javascripts in root.
 * Error when submitting subtitle longer than 255. Show flash.
 * n+1 checks (e.g. likes).
 * Add authorization for everything related to project controller (don't allow edit if not contributor etc).
 * Check organization scopes (search for users, projects, all syncing stuff, validations and controller actions).
 * Error pages work (also when not in organization scope).
 * Specs - add for basic control flows.
 * What happens when organization is deleted? Merge users organization with existing one (only when changing organization).
 * Sweep code base and remove old stuff (JS, Css, controllers, concerns, models, helpers, models, 
 * Make sure postmark works again after production.
 
__NICE TO HAVE:__
 * Edit posts.
 * Paper plane 3d.
 * Emoji autocomplete in posts and fixes in preview mode ('dancer' works, '+1' doesn't).
 * Github activity and project-neggers.