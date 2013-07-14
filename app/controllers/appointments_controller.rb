class AppointmentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_patient
  before_action :set_appointment, only: [:show]
  before_action :set_writable_appointment, only: [:edit, :update, :destroy]

  def index
    @presenter = AppointmentsPresenter.new(current_user, params)
    respond_to do |format|
      format.html
      format.json { render json: @presenter.to_json }
    end
  end

  def show
  end

  def new
    @appointment = Appointment.new
    @appointment.patient = @patient
    @appointment.user = current_user
  end

  def edit
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = @patient
    @appointment.user = current_user
    Rails.logger.debug("@appointment = #{ @appointment.inspect }")
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to [@patient, @appointment], notice: 'Appointment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @appointment }
      else
        format.html { render action: 'new' }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to [@patient, @appointment], notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @appointment.canceled_at = DateTime.now
    @appointment.save!
    respond_to do |format|
      format.html { redirect_to patient_appointments_url(@patient), notice: 'Appointment was canceled.' }
      format.json { head :no_content }
    end
  end

  def uncancel
    @appointment.canceled_at = nil
    @appointment.save!
    respond_to do |format|
      format.html { redirect_to patient_appointments_url(@patient), notice: 'Appointment was un-canceled.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to patient_appointments_url(@patient) }
      format.json { head :no_content }
    end
  end

  private

  def set_appointment
    @appointment = Appointment.by_allowed_user(current_user).find(params[:id])
  end

  def set_writable_appointment
    @appointment = current_user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_type, :start_at_str, :end_at_str, :notes)
  end
end
