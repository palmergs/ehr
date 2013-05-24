class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def set_patient

#puts "Current User = #{ current_user.inspect }"
#puts "Patients = #{ current_user.patients.inspect }"
#puts "All patients = #{ Patient.all.inspect }"
#puts "Patient Doctor relations = #{ PatientDoctorRelation.all.inspect }"

      @patient = current_user.patients.find(params[:patient_id])
    end

end
