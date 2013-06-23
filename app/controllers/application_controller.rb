class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def set_patient
    @patient = current_user.patients.find(params[:patient_id])
  end

  def set_appointment
    @appointment = @patient.appointments.find(params[:appointment_id])
  end
end
