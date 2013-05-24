json.array!(@presenter.collection) do |patient|
  json.extract! patient, :ident, :status, :fname, :mname, :lname, :gender
  json.url patient_url(patient, format: :json)
end