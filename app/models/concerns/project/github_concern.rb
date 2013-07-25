
module Project::GithubConcern
  extend ActiveSupport::Concern

  # Goes into Project

  delegate :readme, :todo, :changelog,
           :website, :last_commit, :contributors,
           :subscribe_to_service_hook,
           :unsubscribe_to_service_hook, :to => :github_grabber


  def sync_with_github
    sync_website_url
    sync_last_commit_date
    sync_contributors
    save!
  end

  def sync_website_url
    self.website_url = 'github_grabber.website'
  end

  def sync_last_commit_date
    self.last_commit_date = Date.now #github_grabber.last_commit.date
  end

  def sync_contributors

  end

  private

  def github_grabber
    @github_grabber ||= GithubGrabber.from_project(self)
  end


end