__FEATURES:__
 * Likes + arrange by likes logic.
 * Differentiate project rows for ideas/projects. 
 * Show edit only if contributor.
 
 * Return to referrer in project page.
 * Find a way to hide users from sync who aren't participating in kata anymore (e.g. Adam, Maxim).
 * Have the 'no projects' thingy in sync as well.
 * Collapsable onboarding with invites.
 * Upload logo image.
 * Bring back delete posts.
 
__SANITY CHECKS:__
 * n+1 checks (e.g. likes)
 * Check organization scopes (search for users, projects, all syncing stuff, validations and controller actions).
 * Sweep i18n, clean it and use proper scopes.
 * Error pages work (also when not in organization scope).
 * Specs - add for basic control flows.
 * What happens when organization is deleted? Merge users organization with existing one (only when changing organization).
 * Sweep code base and remove old stuff.
 * Make sure postmark works again after production.
 
__NICE TO HAVE:__
 * Edit posts.
 * Vector clouds in root.
 * Paper plane 3d.
 * Emoji autocomplete in posts.
 * Github activity and project-neggers.
