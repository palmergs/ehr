module PrescriptionsHelper

  def prescription p
    content_tag(:span, class: "prescription-#{ p.medication_status }") do 
      if p.appointment
        "#{ p.appointment.date_str }: #{ p.prescription }"
      else
        "#{ p.created_at.strftime('%m/%d/%Y') }: #{ p.prescription }"
      end
    end
  end
end
