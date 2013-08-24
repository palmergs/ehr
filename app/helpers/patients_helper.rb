module PatientsHelper
  def gender_icon gender 
    if gender == Gender::FEMALE or gender == Gender::MALE_TO_FEMALE
      image_tag 'silk/female.png'
    elsif gender == Gender::MALE or gender == Gender::FEMALE_TO_MALE
      image_tag 'silk/male.png'
    end
  end

  def patient_title patient
    str = "#{ patient.name }, #{ patient.long_gender }"
    str << ", #{ patient.age } y.o." if patient.age
    str
  end
end
