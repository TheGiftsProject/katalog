module IndexHelper
  def title_for_column(which)
    t(which, scope: "projects.index.title.#{params[:action]}",
              user: @user.try(:shortname))
  end

  def smart_user_projects_path(user)
    if user == current_user
      mine_projects_path
    else
      user_projects_path(:username => user.nickname)
    end
  end

  def active_class_if_page(page)
    current_page?(page) ? {class: 'active'} : {}
  end
end