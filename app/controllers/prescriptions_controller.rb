class PrescriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_prescription, only: [:show]
  before_action :set_writable_prescription, only: [:edit, :update, :destroy]
  before_action :set_patient

  def index
    @presenter = PrescriptionsPresenter.new(current_user, params)
  end

  def show
  end

  def new
    @prescription = Prescription.new
    @prescription.patient = @patient
    @prescription.user = current_user
  end

  def edit
  end

  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.patient = @patient
    @prescription.user = current_user

    respond_to do |format|
      if @prescription.save
        format.html { redirect_to [@patient, @prescription], notice: 'Prescription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prescription }
      else
        format.html { render action: 'new' }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        format.html { redirect_to [@patient, @prescription], notice: 'Prescription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @prescription.destroy
    respond_to do |format|
      format.html { redirect_to patient_prescriptions_url(@patient) }
      format.json { head :no_content }
    end
  end

  private

  def set_prescription
    @prescription = Prescription.by_allowed_user(current_user).find(params[:id])
  end

  def set_writable_prescription
    @prescription = current_user.prescriptions.find(params[:id])
  end

  def prescription_params
    params.require(:prescription).permit(:medication_status, :prescription, :notes)
  end
end
