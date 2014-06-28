class Post < ActiveRecord::Base

  IMAGE_MARKDOWN = /!\[.*\]\((.+)\)/

  belongs_to :project
  belongs_to :user

  validates_presence_of :text

  scope :status_updates, -> { where(:updated => true) }
  scope :has_image, -> { where("text like '%![%](%)%'") }
  scope :reverse, -> { order(:id => :desc) }

  def image_url
    image_urls.first
  end

  def image_urls
    text.scan(IMAGE_MARKDOWN).flatten
  end

end