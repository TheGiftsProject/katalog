class Project < ActiveRecord::Base

  DEFAULT_IMAGE = 'http://placehold.it/200x150'

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  has_many :posts, :dependent => :destroy

  accepts_nested_attributes_for :posts

  enum :status, [:idea, :wip, :done, :dead]

  scope :latest_first, -> { order(:updated_at => :desc) }
  scope :search, lambda {|query| where('lower(title) like ?', query.downcase + '%')}

  validates_presence_of :subtitle, :title

  delegate :readme, :todo, :changelog,
           :website, :last_commit, :contributors,
           :subscribe_to_service_hook,
           :unsubscribe_to_service_hook, :to => :github_grabber

  def to_param
    slug
  end

  def image
    DEFAULT_IMAGE
  end

  def less_than_week_old?
    self.created_at > 1.week.ago
  end

  def string_tags=(array)
    real_tags = array.map do |tag_name|
      Tag.find_caseless(tag_name).first_or_create(:name => tag_name.capitalize)
    end

    self.tags = real_tags
  end

  def sync_with_github
    sync_website_url
    sync_last_commit_date
    sync_contributors
  end

  def sync_website_url
    github_grabber.website
  end

  def sync_last_commit_date

  end

  def sync_contributors

  end

  private

  def slug
    "#{id}-#{title.parameterize}"
  end

  def github_grabber
    @github_grabber ||= GithubGrabber.from_project(self)
  end

end