class PatientDoctorRelation < ActiveRecord::Base

  belongs_to :user
  belongs_to :patient

  validates :user_id, :patient_id, presence: true

end
