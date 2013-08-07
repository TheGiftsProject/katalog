Octokit.configure do |config|
  config.login = ENV['GITHUB_USER']
  config.access_token = ENV['GITHUB_USER_TOKEN']
end