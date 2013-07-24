class Contact < ActiveRecord::Base
  extend ScopedSearch

  belongs_to :patient

  validates :patient_id, :contact, :msg_instr, presence: true

  scope :by_patient, ->(patient_id) { where(patient_id: patient_id) if patient_id }
  scope :by_allowed_user, ->(user) { allowed_user_lambda.call(user) }

end
