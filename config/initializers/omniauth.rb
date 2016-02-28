OmniAuth.config.full_host = "http://katalog.dev" if Rails.env.development?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :slack, ENV["SLACK_APP_ID"], ENV["SLACK_APP_SECRET"], scope: 'identify, users:read, team:read'

end