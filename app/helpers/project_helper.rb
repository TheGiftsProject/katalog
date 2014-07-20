module ProjectHelper

  def class_for_quick_idea
    hide_quick_idea? ? 'hidden-xs' : ''
  end

  def hide_quick_idea?
    !(current_page? projects_path)
  end

  def new_for_current_user?(project)
    project.less_than_week_old? and not viewed_by_current_user?(project)
  end

  def viewed_by_current_user?(project)
    viewed_hash = cookies[:viewed]
    return false unless viewed_hash
    JSON.parse(viewed_hash)[project.id.to_s]
  end

  def back_to_index_url
    session[:referer] || projects_path
  end

  def like_icon_class(liked)
    liked ? 'text-primary' : 'text-muted'
  end

  def collaborator?
    current_project.users.include? current_user
  end

  def project_image(project)
    project.image_url || image_path('no-image.png')
  end

end