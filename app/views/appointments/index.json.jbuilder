json.array!(@appointments) do |appointment|
  json.extract! appointment, :user_id, :patient_id, :appointment_type, :start_at, :end_at, :canceled_at, :notes
  json.url appointment_url(appointment, format: :json)
end