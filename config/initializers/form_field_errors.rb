ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
 error = Array(instance.error_message).first
 %(<span class="validation-error">#{html_tag} #{error}</span>).html_safe
end