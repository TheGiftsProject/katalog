class Project < ActiveRecord::Base

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  has_many :posts

  enum :status, [:idea, :wip, :done, :dead]

end