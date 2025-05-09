# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Remove the default error wrapping div around form fields
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html_tag.html_safe
end
