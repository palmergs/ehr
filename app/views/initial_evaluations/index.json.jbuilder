json.array!(@initial_evaluations) do |initial_evaluation|
  json.extract! initial_evaluation, :user_id, :patient_id, :appointment_id, :id_cc, :hpi, :formulation, :recommendation
  json.url initial_evaluation_url(initial_evaluation, format: :json)
end
