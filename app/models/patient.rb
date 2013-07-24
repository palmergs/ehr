class Patient < ActiveRecord::Base
  extend ScopedSearch
  include PatientStatus
  include Gender

  belongs_to :user

  has_many :patient_doctor_relations, dependent: :destroy
  has_many :users,                    through: :patient_doctor_relations

  has_many :addresses,                dependent: :destroy
  has_many :patient_notes,            dependent: :destroy
  has_many :allergies,                dependent: :destroy
  has_many :prescriptions,            dependent: :destroy
  has_many :appointments,             dependent: :destroy
  has_many :progress_notes,           dependent: :destroy
  has_many :initial_evaluations,      dependent: :destroy

  validates :ident, :status, presence: true

  scope :by_id, ->(id) { where(id: id.to_i) if id and id.to_i > 0 }
  scope :by_ident, ->(ident) { where(ident: ident.to_s) if ident.present? }
  scope :by_dob, ->(stdt, endt) { date_range_lambda.call(stdt, endt, :dob) }
  scope :by_created_at, ->(stdt, endt) { date_range_lambda.call(stdt, endt) }
  scope :by_search, ->(q) { fields_like_lambda.call(q, [:fname, :lname, :mname]) }

  def name
    [ fname, mname, lname ].reject(&:blank?).join(' ')
  end

  def initials
    [ fname, mname, lname ].reject(&:blank?).map {|s| s[0].upcase }.join(' ')
  end   

  def last_interaction
    self.appointments.not_canceled.occurred_before.order('start_at desc').first
  end

  def last_visit
    self.appointments.
        not_canceled.
        occurred_before.
        where(appointment_type: AppointmentType::VISIT_TYPES).
        order('start_at desc').
        first
  end

  def current_and_past_appointments
    self.appointments.occurred_before.order('start_at desc')
  end

  def next_appointment limit = 1
    self.appointments.scheduled_after.not_canceled.order('start_at asc').limit(limit)
  end

  def dob_str= str
    tmp = Date.strptime(str, '%m/%d/%Y')
    self.dob = tmp
  rescue Exception => e
    errors.add(:dob, 'Date must be in MM/DD/YYYY format')
  end

  def dob_str 
    if self.dob
      self.dob.strftime('%m/%d/%Y')
    end
  end

  def prescriptions_in_order desc = true
    self.prescriptions.sort do |lhs,rhs|
      lhs_tm = lhs.appointment ? lhs.appointment.start_at : lhs.created_at
      rhs_tm = rhs.appointment ? rhs.appointment.start_at : rhs.created_at
      if desc
        rhs_tm <=> lhs_tm
      else
        lhs_tm <=> rhs_tm
      end
    end
  end

  def age
    Date.today.year - self.dob.year if self.dob
  end
end
