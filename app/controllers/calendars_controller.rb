class CalendarsController < ApplicationController 

  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @presenter = AppointmentsPresenter.new(current_user, params)
  end

  def show
    redirect_to patient_appointment_path(@appointment.patient, @appointment)
  end

  def new
    @appointment = Appointment.new
    @appointment.user = current_user
  end

  def edit

  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    @appointment.patient = current_user.patients.find(params[:patient_id])

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to calendars_path, notice: 'Appointment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @appointment }
      else
        format.html { render action: 'new' }
        format.json { render json: @appointment.errors, status: :unproccessable_untity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to calendars_path, notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to calendars_path }
      format.json { head :no_content }
    end
  end

  private

  def set_appointment
    @appointment = Appointment.by_allowed_user(current_user).find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_type, :start_at, :end_at, :canceled_at, :notes)
  end

end
