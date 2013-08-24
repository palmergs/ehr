require 'test_helper'

class ProgressNotesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @patient = patients(:one)
    @appointment = appointments(:one)
    @progress_note = progress_notes(:one)
  end

  test "should get index" do
    get :index, patient_id: @patient.id, appointment_id: @appointment.id
    assert_response :success
    assert_not_nil assigns(:presenter)
  end

  test "should get new" do
    get :new, patient_id: @patient.id, appointment_id: @appointment.id
    assert_redirected_to edit_patient_appointment_progress_note_path(
        @patient, 
        @appointment, 
        @appointment.progress_note)
  end

  test "should create progress_note" do
    assert_difference('ProgressNote.count') do
      post :create, patient_id: @patient.id, appointment_id: @appointment.id,
          progress_note: { appearance: @progress_note.appearance, 
              behavior: @progress_note.behavior, 
              cognitive_state: @progress_note.cognitive_state, 
              delusions: @progress_note.delusions, 
              hallucinations: @progress_note.hallucinations, 
              impression_diagnosis: @progress_note.impression_diagnosis, 
              insight_judgement: @progress_note.insight_judgement, 
              interim_history: @progress_note.interim_history, 
              majority_counceling_coord: @progress_note.majority_counceling_coord, 
              medications_side_effects: @progress_note.medications_side_effects, 
              mood_affect: @progress_note.mood_affect, 
              phobias_obsessions: @progress_note.phobias_obsessions, 
              plan: @progress_note.plan, 
              sihi: @progress_note.sihi, 
              speech: @progress_note.speech, 
              therapy_mins: @progress_note.therapy_mins, 
              therapy_type: @progress_note.therapy_type, 
              thought_process: @progress_note.thought_process, 
              vital_sense: @progress_note.vital_sense }
    end

    assert_redirected_to patient_appointment_path(@patient, @appointment)
  end

  test "should show progress_note" do
    get :show, id: @progress_note, 
        patient_id: @patient.id, 
        appointment_id: @appointment.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @progress_note, 
        patient_id: @patient.id, 
        appointment_id: @appointment.id
    assert_response :success
  end

  test "should update progress_note" do
    patch :update, patient_id: @patient.id, 
        id: @progress_note, 
        appointment_id: @appointment.id,
        progress_note: { appearance: @progress_note.appearance, 
            behavior: @progress_note.behavior, 
            cognitive_state: @progress_note.cognitive_state, 
            delusions: @progress_note.delusions, 
            hallucinations: @progress_note.hallucinations, 
            impression_diagnosis: @progress_note.impression_diagnosis, 
            insight_judgement: @progress_note.insight_judgement, 
            interim_history: @progress_note.interim_history, 
            majority_counceling_coord: @progress_note.majority_counceling_coord, 
            medications_side_effects: @progress_note.medications_side_effects, 
            mood_affect: @progress_note.mood_affect, 
            phobias_obsessions: @progress_note.phobias_obsessions, 
            plan: @progress_note.plan, 
            sihi: @progress_note.sihi, 
            speech: @progress_note.speech, 
            therapy_mins: @progress_note.therapy_mins, 
            therapy_type: @progress_note.therapy_type, 
            thought_process: @progress_note.thought_process, 
            vital_sense: @progress_note.vital_sense }
    assert_redirected_to patient_appointment_path(@patient, @appointment)
  end

  test "should destroy progress_note" do
    assert_difference('ProgressNote.count', -1) do
      delete :destroy, id: @progress_note, 
          patient_id: @patient.id, 
          appointment_id: @appointment.id
    end

    assert_redirected_to patient_path(@patient)
  end
end
