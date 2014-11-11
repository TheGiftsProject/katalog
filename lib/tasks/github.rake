namespace :github do

  desc 'Github related tasks'

  task :update_activity => :environment do
    GithubActivityUpdater.new.update_activity
  end
end