class InitialEvaluationsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_patient
  before_action :set_appointment
  before_action :set_initial_evaluation, only: [:show]
  before_action :set_writable_initial_evaluation, only: [:edit, :update, :destroy]

  def index
    @presenter = InitialEvaluationsPresenter.new current_user, params
  end

  def show
  end

  def new
    @initial_evaluation = @appointment.initial_evaluation
    if @initial_evaluation
      redirect_to [@patient, @appointment, @initial_evaluation]
    else
      @initial_evaluation = InitialEvaluation.new
      @initial_evaluation.user = current_user
      @initial_evaluation.patient = @patient
      @initial_evaluation.appointment = @appointment
    end
  end

  def edit
  end

  def create
    @initial_evaluation = InitialEvaluation.new(initial_evaluation_params)
    @initial_evaluation.user = current_user
    @initial_evaluation.patient = @patient
    @initial_evaluation.appointment = @appointment
    respond_to do |format|
      if @initial_evaluation.save
        format.html { redirect_to [@patient, @appointment, @initial_evaluation], notice: 'Initial evaluation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @initial_evaluation }
      else
        format.html { render action: 'new' }
        format.json { render json: @initial_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @initial_evaluation.update(initial_evaluation_params)
        format.html { redirect_to [@patient, @appointment, @initial_evaluation], notice: 'Initial evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @initial_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @initial_evaluation.destroy
    respond_to do |format|
      format.html { redirect_to patient_url(@patient) }
      format.json { head :no_content }
    end
  end

  private
    def set_initial_evaluation
      @initial_evaluation = InitialEvaluation.by_allowed_user(current_user).find(params[:id])
    end

    def set_writable_initial_evaluation
      @initial_evaluation = current_user.initial_evaluations.find(params[:id])
    end

    def initial_evaluation_params
      params.require(:initial_evaluation).permit(:id_cc, 
          :hpi, 
          :mental_status_exam, 
          :formulation, 
          :recommendation)
    end
end
