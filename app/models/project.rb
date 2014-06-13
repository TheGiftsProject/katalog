class Project < ActiveRecord::Base

  DEFAULT_IMAGE = 'http://placehold.it/200x150'

  has_and_belongs_to_many :users
  has_many :posts, :dependent => :destroy

  accepts_nested_attributes_for :posts

  enum :status, [:idea, :wip, :done]

  scope :recent, -> { where(:updated_at => 2.week.ago..DateTime.now) }
  scope :latest_first, -> { order('updated_at DESC') }
  scope :search, lambda {|query| where('lower(title) like ?', query.downcase + '%')}

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

  private

  def slug
    "#{id}-#{title.parameterize}"
  end

  def last_posted_image
    posts.has_image.last.try(:image_url)
  end

end