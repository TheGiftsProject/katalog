require 'hashie/trash'

class RepoSearchResult < Hashie::Trash

  def initialize(repo_data)
    super( self.class.keep_only_defined_properties(repo_data) )
  end

  property :repo_id, :from => :id
  property :repo_url, :from => :html_url
  property :name, :from => :full_name
  property :description
  property :language

  private

  def self.keep_only_defined_properties(raw_data)
    raw_data = raw_data.to_hash
    selected_properties = self.class.properties + self.class.translations
    filtered_data = raw_data.keep_if { |k,v| selected_properties.include?(k) }
  end

end