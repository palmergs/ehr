class ProgressNote < ActiveRecord::Base
  extend ScopedSearch

  belongs_to :patient
  belongs_to :user
  belongs_to :appointment

  validates :patient_id, :user_id, :appointment_id, presence: true

  scope :by_user, ->(user_id) { where(user_id: user_id) if user_id }
  scope :by_patient, ->(patient_id) { where(patient_id: patient_id) if patient_id }
  scope :by_allowed_user, ->(user) { allowed_user_lambda.call(user) }

  def date
    self.appointment.start_at
  end
end
