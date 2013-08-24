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

  def datetime_input form, field, options = HashWithIndifferentAccess.new
    render partial: 'layouts/datetime_input', locals: { f: form, field: field, options: options }
  end

  def date_input form, field, options = HashWithIndifferentAccess.new
    render partial: 'layouts/date_input', locals: { f: form, field: field, options: options }
  end

  def on_dt datetime
    if datetime
      datetime.strftime("%l:%M, %m/%d/%Y")
    end
  end

  def undefn text='undefined'
    content_tag :span, text.to_s, class: 'undef'
  end

  def md str
    if str
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      @markdown.render(str).html_safe
    end
  end

  def ns obj, field = nil
    unless obj.nil?
      if field
        tmp = obj.call(field.to_sym)
        tmp.nil? ? undefn : tmp
      else
        obj
      end
    else
      undefn
    end
  end
end
