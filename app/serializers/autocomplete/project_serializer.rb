class Autocomplete::ProjectSerializer < ActiveModel::Serializer
  attributes :title, :url

  def url
    project_url(object)
  end
end