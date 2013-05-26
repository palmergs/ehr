class Appointment < ActiveRecord::Base
  extend ScopedSearch
  include AppointmentType

  belongs_to :user
  belongs_to :patient

  has_many :progress_notes
  has_many :prescriptions
  has_many :allergies

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

  def summary
    "#{ self.appointment_type } #{ self.start_at_str }"
  end

  def date_str 
    self.start_at.strftime('%m/%d/%Y')
  end

  def start_at_str= str
    self.start_at = DateTime.strptime(str, '%m/%d/%Y %I:%M %p')
  rescue Exception => e
    errors.add(:start_at, 'Date / time format must be MM/DD/YYYY HH:MM AM/PM')
  end

  def start_at_str
    if start_at
      start_at.strftime('%m/%d/%Y %I:%M %p')
    end
  end

  def end_at_str= str
    self.end_at = DateTime.strptime(str, '%m/%d/%Y %I:%M %p')
  rescue Exception => e
    errors.add(:end_at, 'Date / time format must be MM/DD/YYYY HH:MM AM/PM')
  end

  def end_at_str
    if end_at
      end_at.strftime('%m/%d/%Y %I:%M %p')
    end
  end

  def duration_mins
    if start_at and end_at and end_at > start_at
      ((end_at - start_at) * 3600).to_i 
    else
      nil
    end
  end

  def self.find_or_create_for user, patient, id, params
    return nil unless user and patient and params
    return nil unless user.patients.find(patient.id)

    if id and id.to_i > 0
      Appointment.by_patient(patient.id).by_allowed_user(user).find(id)
    elsif params[:appointment_type] and params[:start_at_str]
      a = Appointment.new
      a.appointment_type = params[:appointment_type]
      a.start_at_str = params[:start_at_str]
      a.end_at_str = params[:end_at_str]
      a.user = user
      a.patient = patient
      a.save
      a
    end
  end
end
