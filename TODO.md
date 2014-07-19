__FEATURES:__
 * Arrange by likes logic.
 
 * Return to referrer in project page (we already have helpers for these in the controller - 'referrer').
 * Have the 'no projects' thingy in sync as well.
 * Collapsable onboarding with invites.
 * Bring back delete posts.
 
__SANITY CHECKS:__
 * Error when submitting subtitle longer than 255. Show flash.
 * n+1 checks (e.g. likes).
 * Add authorization for everything related to project controller (don't allow edit if not contributor etc).
 * Check organization scopes (search for users, projects, all syncing stuff, validations and controller actions).
 * Sweep i18n, clean it and use proper scopes.
 * Error pages work (also when not in organization scope).
 * Specs - add for basic control flows.
 * What happens when organization is deleted? Merge users organization with existing one (only when changing organization).
 * Sweep code base and remove old stuff.
 * Make sure postmark works again after production.
 
__NICE TO HAVE:__
 * Edit posts.
 * Plain clouds in root.
 * Paper plane 3d.
 * Emoji autocomplete in posts.
 * Github activity and project-neggers.
 
 __SMALL BUGS__
 * Emoji in preview mode aren't always translate well ('dancer' works, '+1' doesn't).
