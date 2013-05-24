module ApplicationHelper
  
  # Use in a form:
  # <%= form_for(@obj) do |f|
  #  <%= errors_in @obj %>
  # ....
  def errors_in obj
    if obj.respond_to?(:errors) and obj.errors.any?
      plural = pluralize obj.errors.count, 'error'
      name = obj.class.name.underscore.humanize.downcase
      content_tag :div, class: 'error-block text-error' do
        [
          content_tag(:h4, "#{ plural } prevented this #{ name } from being saved:"),
          content_tag(:ul) do
            obj.errors.full_messages.map do |msg|
              content_tag(:li, msg)
            end.join.html_safe
          end
        ].join.html_safe
      end
    end
  end
end
