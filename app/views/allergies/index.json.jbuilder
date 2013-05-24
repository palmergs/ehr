json.array!(@allergies) do |allergy|
  json.extract! allergy, :user_id, :patient_id, :medication_or_food, :reaction
  json.url allergy_url(allergy, format: :json)
end