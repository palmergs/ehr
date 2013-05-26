module AppointmentsHelper

  def appointment a
    text = "#{ a.start_at_str }"
    text << " (#{ a.duration_mins } mins)" if a.duration_mins
    link_to text, "##{ a.start_at_str }", 
        class: "appointment-#{ a.appointment_type.gsub(/\s/,'') }",
        title: "#{ a.appointment_type } on #{ a.start_at_str }"
  end
end
