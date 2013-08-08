Octokit.configure do |config|
  config.login = ENV['GITHUB_USER']
  config.oauth_token = ENV['GITHUB_USER_TOKEN']
end