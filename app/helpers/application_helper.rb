module ApplicationHelper

  def class_if(klass, condition)
    if condition
      {:class => klass}
    else
      {}
    end
  end
end
