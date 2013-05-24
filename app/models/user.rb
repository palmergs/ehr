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

end
