require 'hashie/trash'

class RepoSearchResult < Hashie::Trash

  property :repo_id, :from => :id
  property :repo_url, :from => :html_url
  property :name, :from => :full_name
  property :description
  property :language

end