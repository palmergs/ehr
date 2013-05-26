class PatientPresenter < DelegateClass(Patient) 

  def initialize current_user, patient
    super(patient)
  end

  def by_date
    hash = Hash.new {|hash,key| 
      hash[key] = { appointment: nil, 
          prescriptions: [], 
          allergies: [], 
          progress_notes: [] } }
    self.appointments.occurred_before.order('start_at desc').each do |a|
      hash[a.start_at_str][:appointment] = a
      hash[a.start_at_str][:prescriptions] = a.prescriptions
      hash[a.start_at_str][:progress_notes] = a.progress_notes
      hash[a.start_at_str][:allergies] = a.allergies
    end

    hash
  end
end
