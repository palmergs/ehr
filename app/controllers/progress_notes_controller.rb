class ProgressNotesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_patient
  before_action :set_progress_note, only: [:show]
  before_action :set_writable_progress_note, only: [:edit, :update, :destroy]

  def index
    @presenter = ProgressNotesPresenter.new current_user, params
  end

  def show
  end

  def new
    @progress_note = ProgressNote.new
    @progress_note.user = current_user
    @progress_note.patient = @patient
  end

  def edit
  end

  def create
    @appointment = Appointment.find_or_create_for(current_user, 
        @patient, 
        params[:appointment_id], 
        params[:appointment])

    @progress_note = ProgressNote.new(progress_note_params)
    @progress_note.user = current_user
    @progress_note.patient = @patient
    @progress_note.appointment = @appointment
    respond_to do |format|
      if @progress_note.save
        format.html { redirect_to [@patient, @progress_note], notice: 'Progress note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @progress_note }
      else
        format.html { render action: 'new' }
        format.json { render json: @progress_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @progress_note.update(progress_note_params)
        format.html { redirect_to [@patient, @progress_note], notice: 'Progress note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @progress_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @progress_note.destroy
    respond_to do |format|
      format.html { redirect_to patient_url(@patient) }
      format.json { head :no_content }
    end
  end

  private

  def set_progress_note
    @progress_note = ProgressNote.by_allowed_user(current_user).find(params[:id])
  end


  def set_writable_progress_note
    @progress_note = current_user.progress_notes.find(params[:id])
  end

  def progress_note_params
    params.require(:progress_note).permit(:interim_history, 
        :medications_side_effects, 
        :impression_diagnosis, 
        :plan, 
        :therapy_type, 
        :therapy_mins, 
        :majority_counceling_coord, 
        :appearance, 
        :behavior, 
        :speech, 
        :though_process, 
        :mood_affect, 
        :vital_sense, 
        :sihi, 
        :hallucinations, 
        :delusions, 
        :phobias_obsessions, 
        :cognitive_state, 
        :insight_judgement)
  end
end
