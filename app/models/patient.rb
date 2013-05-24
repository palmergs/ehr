class Patient < ActiveRecord::Base
  extend ScopedSearch
  include PatientStatus
  include Gender

  belongs_to :user

  has_many :patient_doctor_relations, dependent: :destroy
  has_many :users,                    through: :patient_doctor_relations

  has_many :patient_notes,            dependent: :destroy
  has_many :allergies,                dependent: :destroy
  has_many :prescriptions,            dependent: :destroy
  has_many :appointments,             dependent: :destroy
  has_many :progress_notes,           dependent: :destroy

  validates :ident, :status, presence: true

  scope :by_id, -> (id) { where(id: id.to_i) if id and id.to_i > 0 }
  scope :by_ident, -> (ident) { where(ident: ident.to_s) if ident.present? }
  scope :by_dob, -> (stdt, endt) { date_range_lambda.call(stdt, endt, :dob) }
  scope :by_created_at, -> (stdt, endt) { date_range_lambda.call(stdt, endt) }
  scope :by_search, -> (q) { fields_like_lambda.call(q, [:fname, :lname, :mname]) }

  def name
    [ fname, mname, lname ].reject(&:blank?).join(' ')
  end

  def initials
    [ fname, mname, lname ].reject(&:blank?).map {|s| s[0].upcase }.join(' ')
  end   

  def last_interaction
    self.appointments.occurred_before.order('start_at desc').first
  end

  def last_visit
    self.appointments.
        occurred_before.
        where(appointment_type: AppointmentType::VISIT_TYPES).
        order('start_at desc').
        first
  end

  def next_appointment
    self.appointments.scheduled_after.order('start_at asc').first
  end

  def age
    Date.today.year - self.dob.year if self.dob
  end
end
