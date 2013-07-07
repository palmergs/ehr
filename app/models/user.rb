class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :encryptable, :confirmable, :lockable, 
  # :timeoutable and :omniauthable
  devise :database_authenticatable,   
      :registerable,
      :recoverable,
      :rememberable, 
      :confirmable,
      :trackable, 
      :validatable

  has_many :patient_doctor_relations, dependent: :destroy
  has_many :patients, through: :patient_doctor_relations

  # Entered by this user 
  has_many :progress_notes
  has_many :prescriptions
  has_many :appointments
  has_many :allergies

  def name
    [fname, lname].select(&:present?).join(' ')
  end

  def initials
    [fname, lname].select(&:present?).map {|s| s[0].upcase}.join
  end

  def appointments_by_hour start_at = Time.now, end_at = Time.now.end_of_day
    appointments.
        time_between(start_at, end_at).
        order('start_at asc').inject({}) do |hash, appt|
      
      key = appt.start_at.strftime('%l:%M %P')
      hash[key] ||= []
      hash[key] << appt
      hash
    end
  end

  def appointments_by_date start_at = 5.days.ago, end_at = 5.days.from_now, order = :asc
    hash = {}
    (start_at.to_date..end_at.to_date).each do |dt|
      hash[dt] = appointments.
          time_between(dt.beginning_of_day, dt.end_of_day).
          order(order.to_sym == :asc ? 'start_at asc' : 'start_at desc')
    end
    hash
  end
end
