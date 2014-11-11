class GithubActivityUpdater

  TIME_THRESHOLD_FOR_PROJECT_ACTIVITY_UPDATE = 6.months
  TIME_SINCE_LAST_ACTIVITY_UPDATE = 1.day

  def initialize
    @api = github_api_client
  end

  def update_activity
    relevant_projects.each do |project|
      repo_name = project.github_repo_name
      branches = branches_of_project(repo_name)
      branches.each do |branch_name|
        commits = commits_of_branch(branch_name)
        mapped_commits = map_commits(commits)
        # check that user still exist.
      end
    end
  end

  private

  def github_api_client
    Octokit::Client.new(:access_token => ENV['GITHUB_SECRET'])
  end

  def relevant_projects
    Project.where('updated_at > ?', TIME_THRESHOLD_FOR_PROJECT_ACTIVITY_UPDATE.ago).have_github_repo
  end

  def branches_of_project(repo_name)
    @api.branches(repo_name).map(&:name)
  end

  def commits_of_branch(branch_name)
    @api.commits_since(repo_name, TIME_SINCE_LAST_ACTIVITY_UPDATE.ago, branch_name)
  end

  def map_commits(commits)
    commits.map do |commit|
      {
        :updated_at => commit[:commit][:author][:date],
        :committer => commit[:committer][:login]
      }
    end
  end

end