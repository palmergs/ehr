class Appointment < ActiveRecord::Base
  extend ScopedSearch
  include AppointmentType

  belongs_to :user
  belongs_to :patient

  validates :patient_id, :user_id, :start_at, :appointment_type, presence: true

  scope :by_user, -> (user_id) { where(user_id: user_id) if user_id }
  scope :by_patient, -> (patient_id) { where(patient_id: patient_id) if patient_id }
  scope :by_allowed_user, -> (user) { allowed_user_lambda.call(user) }
  scope :time_between, -> (sdt, edt) { date_range_lambda.call(sdt, edt, :start_at) }
  scope :not_canceled, -> { where(canceled_at: nil) }
  scope :occurred_before, -> (time = nil) {
    time ||= Time.now
    where(canceled_at: nil).where('start_at <= ?', time)
  }

  scope :scheduled_after, -> (time = nil) {
    time ||= Time.now
    where(canceled_at: nil).where('start_at >= ?', time)
  }

  scope :canceled_between, -> (sdt, edt) { date_range_lambda.call(sdt, edt, :canceled_at) }
  scope :by_appointment_type, -> (type) {
    where(appointment_type: type) if APPOINTMENT_TYPES.include?(type)
  }

  def self.find_or_create_for_user current_user, params
    if params[:appointment_id]
      Appointment.by_allowed_user(current_user).find(params[:appointment_id])
    else
      a = Appointment.build(params[:appointment])
      a.user = current_user
      a.patient = current_user.patients.find(params[:patient_id])
      a.save
      a
    end
  end
end
