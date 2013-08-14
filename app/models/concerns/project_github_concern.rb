
module ProjectGithubConcern
  extend ActiveSupport::Concern

  # Goes into Project

  # Example: current_project.github_readme, etc...
  delegate :readme,
           :todo,
           :changelog,
           :to => :github_grabber, :prefix => :github

  def includes_contributors?(contributors_emails)
    current_contributors_emails = Set.new(self.users.map(&:email))
    new_contributors_emails = Set.new(contributors_emails)
    new_contributors_emails.subset?(current_contributors_emails)
  end

  # Compares the current Project's repo to a given repo url or Project's repo url
  #
  # @param repo [String, Project] Either a A GitHub repository url or a Project model
  def same_repo?(repo)
    repo = repo.repo_url if repo.is_a? Project
    current_repo = Octokit::Repository.from_url(self.repo_url)
    other_repo = Octokit::Repository.from_url(repo)
    current_repo.slug == other_repo.slug
  end

  private

  def github_grabber
    @github_grabber ||= Github::Grabber.new(self)
  end

end