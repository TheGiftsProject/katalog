class AddImageUrlToProject < ActiveRecord::Migration
  def change
    add_column :projects, :image_url, :string

    Project.find_each do |project|
      image_url = project.posts.has_image.last.try(:image_url)
      project.update(image_url: image_url)
    end

  end
end
