class PatientsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_patient, only: [ :show, :edit, :update, :destroy ]

  def index
    @presenter = PatientsPresenter.new(current_user, params)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def ethnicities
    @presenter = PatientsPresenter.new(current_user, params)
    render json: {
      options: @presenter.ethnicities
    }
  end

  def occupations
    @presenter = PatientsPresenter.new(current_user, params)
    render json: {
      options: @presenter.occupations
    }
  end

  def marital_statuses
    @presenter = PatientsPresenter.new(current_user, params)
    render json: {
      options: @presenter.marital_statuses
    }
  end

  def show
    @patient = PatientPresenter.new(current_user, @patient)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @patient = Patient.new
    @patient.user = current_user
  end

  def create
    @patient = Patient.new(create_params)
    @patient.user = current_user
    if @patient.save
      PatientDoctorRelation.create(user: current_user, patient: @patient)
      redirect_to @patient, notice: 'Patient created'
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @patient.update_attributes(update_params)
      redirect_to @patient, notice: 'Patient information successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @patient.status = PatientStatus::DELETED
    if @patient.save
      redirect_to patients_path, notice: 'Patient marked as deleted'
    else
      redirect_to patients_path, flash: { warning: 'Unable to mark the patient as deleted.' }
    end
  end

  private 

  def set_patient
    @patient = current_user.patients.find(params[:id])
  end

  def create_params
    params.require(:patient).permit(:ident, :status, :fname, :mname, :lname, :dob, :dob_str, :marital_status, :occupation, :ethnicity, :gender)
  end

  def update_params
    params.require(:patient).permit(:fname, :mname, :lname, :dob, :dob_str, :marital_status, :occupation, :ethnicity, :gender)
  end
end
