Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
  else
    provider :developer
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end
end