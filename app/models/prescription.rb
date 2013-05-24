class Prescription < ActiveRecord::Base
  extend ScopedSearch

  belongs_to :patient
  belongs_to :user

  validates :patient_id, :user_id, presence: true

  scope :by_user, -> (user_id) { where(user_id: user_id) if user_id }
  scope :by_patient, -> (patient_id) { where(patient_id: patient_id) if patient_id }
  scope :by_allowed_user, -> (user) { allowed_user_lambda.call(user) }
  scope :by_created_at, -> (stdt, endt) { date_range_lambda.call(stdt, endt) }
  scope :by_search, -> (q) { fields_like_lambda.call(q, :prescription) }

end
