module ApplicationHelper
  def flash_content(key, value)
    unless value.blank? || key == :timedout
      content_tag(:div, value, class: "alert alert-#{flash_type(key)}").html_safe
    end
  end

  def flash_type(key)
    case key
    when "alert" then :warning
    when "notice" then :success
    when "error" then :error
    end
  end

  def path_for_user(user)
    user.rep_admin? ? rep_path(user.profile.slug) : citizen_path(user)
  end

  def set_body_class(controller, action)
    if controller == "sessions" && action == "new"
      "landing-background"
    else
      "#{controller} #{action}"
    end
  end
end
