class Tag < ActiveRecord::Base

  has_and_belongs_to_many :projects

  scope :search, lambda {|query| where('lower(name) like ?', query.downcase + '%')}

end