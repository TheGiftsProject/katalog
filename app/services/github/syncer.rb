require 'octokit'

class Github::Syncer

  attr_accessor :project

  def initialize(project)
    @project = project
  end

  def creation_sync
    sync
  end

  def update_sync
    sync if should_update_sync?
  end

  def destruction_sync
    github_grabber.unsubscribe_to_service_hook if should_sync?
  end

  def sync
    return unless should_sync?
    github_grabber.subscribe_to_service_hook
    sync_demo_url
    sync_last_commit_date
    sync_contributors

    project.save!
  end

  def should_sync?
    project.repo_url.present?
  end

  def should_update_sync?
    project.repo_url_was.blank?
  end

  def sync_demo_url
    project.demo_url = github_grabber.website
  end

  def sync_last_commit_date
    project.last_commit_date = github_grabber.last_commit.date
  end

  def sync_contributors
    existing_users_uids = project.users.map(&:uid)
    github_grabber.contributors.each do |contributor|
      assign_contributor(contributor) unless existing_users_uids.include?(contributor.id)
    end
  end

  private

  def github_grabber
    @github_grabber ||= Github::Grabber.new(project)
  end

  def assign_contributor(contributor)
    new_contributor = User.find_or_init_by_contributor(contributor)

    # if the user already exists then just add it to his projects
    new_contributor.projects << project unless new_contributor.projects.include?(project)
    new_contributor.save!
  end

end