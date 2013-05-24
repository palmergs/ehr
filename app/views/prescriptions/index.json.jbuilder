json.array!(@presenter.collection) do |prescription|
  json.extract! prescription, :user_id, :patient_id, :medication_status, :prescription, :notes
  json.url prescription_url(prescription, format: :json)
end
