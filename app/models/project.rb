class Project < ActiveRecord::Base

  DEFAULT_IMAGE = 'http://placehold.it/300x300'

  belongs_to :ideator, :class_name => 'User'
  belongs_to :organization
  has_and_belongs_to_many :users
  has_many :posts, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  accepts_nested_attributes_for :posts

  self.per_page = 10

  enum :status, [:idea, :lifted]

  scope :latest_first, -> { order('projects.updated_at DESC') }
  scope :trending, -> { where(updated_at: ((Date.today-1.month)..(Date.today+1.day))) }
  scope :search, -> (query) { query.blank? ? none : where('lower(title) like ? or lower(title) like ?',
                                                              "#{query.downcase}%", "% #{query.downcase}%")}
  scope :of_user, -> (user) { includes(:users).where(:users => {:id => user.id}) }

  validates_presence_of :subtitle, :title

  def to_param
    slug
  end

  def image
    last_posted_image || DEFAULT_IMAGE
  end

  def less_than_week_old?
    self.created_at > 1.week.ago
  end

  def ideator
    self[:ideator].presence || users.first
  end

  def lift!
    update(
        lifted_at: DateTime.now,
        status: :lifted
    )
  end

  private

  def slug
    "#{id}-#{title.parameterize}"
  end

  def last_posted_image
    posts.has_image.last.try(:image_url)
  end

end