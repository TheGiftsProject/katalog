class Tag < ActiveRecord::Base

  has_and_belongs_to_many :projects

  scope :search, lambda {|query| where('lower(name) like ?', query.downcase + '%')}
  scope :find_caseless, lambda {|query| where('lower(name) = ?', query.downcase )}

  validates_presence_of :name

end