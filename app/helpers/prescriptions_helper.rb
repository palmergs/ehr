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

  MEDICATION_STATUS_TO_LABEL = {
    MedicationStatus::PRESCRIBED => 'label-success',
    MedicationStatus::CEASED => '',
    MedicationStatus::INCREASED => 'label-info',
    MedicationStatus::DECREASED => 'label-info'
  }

  def prescription_span p
    content_tag :span, 
        p.medication_status, 
        class: "label #{ MEDICATION_STATUS_TO_LABEL[p.medication_status] }"
  end
end
