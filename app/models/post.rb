class Post < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  validates_presence_of :text

end