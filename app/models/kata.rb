class Kata < ActiveRecord::Base
  has_and_belongs_to_many :tags

  enum :status, [:idea, :wip, :done, :dead]
end