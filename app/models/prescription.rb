class Prescription < ActiveRecord::Base
  extend ScopedSearch

  belongs_to :patient
  belongs_to :user
  belongs_to :appointment

  validates :patient_id, :user_id, presence: true

  scope :by_user, -> (user_id) { where(user_id: user_id) if user_id }
  scope :by_patient, -> (patient_id) { where(patient_id: patient_id) if patient_id }
  scope :by_allowed_user, -> (user) { allowed_user_lambda.call(user) }
  scope :by_created_at, -> (stdt, endt) { date_range_lambda.call(stdt, endt) }
  scope :by_search, -> (q) { fields_like_lambda.call(q, :prescription) }

  def summary 
    arr = []
    arr << appointment.start_at.strftime('%m/%d/%Y') if appointment
    arr << self.medication_status
    arr << self.prescription
    arr.join(' ')
  end

  def date
    self.appointment ? self.apppointment.start_at : self.created_at
  end

  def date_str
    self.date.strftime('%m/%d/%Y')
  end

end
