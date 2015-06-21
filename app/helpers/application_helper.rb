module ApplicationHelper

  def is_active?(action_name)
    controller.action_name == action_name ? "active" : ""
  end

end
