OmniAuth.config.full_host = "http://katalog.dev" if Rails.env.development?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end