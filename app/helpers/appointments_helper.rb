module AppointmentsHelper

  def appointment a, same_page = true
    if a
      text = "#{ a.start_at_str }"
      text << " (#{ a.duration_mins } mins)" if a.duration_mins
      if same_page
        link_to text, "##{ a.start_at_str }", 
            class: "appointment-#{ a.appointment_type.gsub(/\s/,'') }",
            title: "#{ a.appointment_type } on #{ a.start_at_str }"
      else
        link_to text, patient_appointment_path(a.patient, a), 
            class: "appointment-#{ a.appointment_type.gsub(/\s/,'') }",
            title: "#{ a.appointment_type } on #{ a.start_at_str }"
      end
    end
  end

  def appt_in_sidebar a
    if a
      p = a.patient
      [
        link_to("#{ a.start_at.strftime('%l:%M %P') }", [p, a]),
        " &ndash; ",
        link_to(p.ident, p),
        ' (',
        link_to(a.appointment_type, [p, a]),
        ')'
      ].join.html_safe
    end
  end
end
