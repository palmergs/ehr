class AllergiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_allergy, only: [:show]
  before_action :set_writable_allergy, only: [:edit, :update, :destroy]
  before_action :set_patient

  def index
    @presenter = AllergiesPresenter.new(current_user, params)
  end

  def show
  end

  def new
    @allergy = Allergy.new
    @allergy.user = current_user
    @allergy.patient = @patient
  end

  def edit
  end

  def create
    @allergy = Allergy.new(allergy_params)
    @allergy.user = current_user
    @allergy.patient = @patient
    respond_to do |format|
      if @allergy.save
        format.html { redirect_to @patient, notice: 'Allergy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @allergy }
      else
        format.html { render action: 'new' }
        format.json { render json: @allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @allergy.update(allergy_params)
        format.html { redirect_to @patient, notice: 'Allergy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @allergy.destroy
    respond_to do |format|
      format.html { redirect_to patient_url(@patient) }
      format.json { head :no_content }
    end
  end

  private

  def set_allergy
    @allergy = Allergy.by_allowed_user(current_user).find(params[:id])
  end

  def set_writable_allergy
    @allergy = current_user.allergies.find(params[:id])
  end

  def allergy_params
    params.require(:allergy).permit(:medication_or_food, :reaction)
  end
end
