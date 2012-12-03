module ApplicationHelper
  def flash_for_js key, value
    escape_javascript(render partial: 'layouts/flash', locals: {key: key, value: value})
  end
end
