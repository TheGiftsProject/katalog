class GithubActivityUpdater

  TIME_THRESHOLD_FOR_PROJECT_ACTIVITY_UPDATE = 6.months
  TIME_SINCE_LAST_ACTIVITY_UPDATE = 1.day

  def initialize
    @api = github_api_client
  end

  def update_activity
    relevant_projects.each do |project|
      branches = branches_of_project(project)
      # check that user still exist.
    end
  end

  private

  def github_api_client
    Octokit::Client.new(:access_token => ENV['GITHUB_SECRET'])
  end

  def relevant_projects
    Project.where('updated_at > ?', TIME_THRESHOLD_FOR_PROJECT_ACTIVITY_UPDATE.ago).have_github_repo
  end

  def branches_of_project(project)

  end

end