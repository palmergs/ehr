require 'test_helper'

class InitialEvaluationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @patient = patients(:one)
    @appointment = appointments(:one)
    @initial_evaluation = initial_evaluations(:one)
  end

  test "should get index" do
    get :index, patient_id: @patient.id, appointment_id: @appointment.id
    assert_response :success
    assert_not_nil assigns(:presenter)
  end

  test "should redirect new since one already exists" do
    get :new, patient_id: @patient.id, appointment_id: @appointment.id
    assert_redirected_to edit_patient_appointment_initial_evaluation_path(@patient, @appointment, @initial_evaluation.id)
  end

  test "should create initial_evaluation" do
    assert_difference('InitialEvaluation.count') do
      post :create, patient_id: @patient.id, appointment_id: @appointment.id, 
          initial_evaluation: { formulation: @initial_evaluation.formulation, 
              hpi: @initial_evaluation.hpi, 
              id_cc: @initial_evaluation.id_cc, 
              mental_status_exam: @initial_evaluation.mental_status_exam, 
              recommendation: @initial_evaluation.recommendation }
    end

    assert_redirected_to patient_appointment_path(@patient, @appointment) 
  end

  test "should show initial_evaluation" do
    get :show, id: @initial_evaluation, 
        patient_id: @patient.id,
        appointment_id: @appointment.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @initial_evaluation,
        patient_id: @patient.id,
        appointment_id: @appointment.id
    assert_response :success
  end

  test "should update initial_evaluation" do
    patch :update, id: @initial_evaluation, patient_id: @patient.id, appointment_id: @appointment.id, 
        initial_evaluation: { formulation: @initial_evaluation.formulation, 
            hpi: @initial_evaluation.hpi, 
            id_cc: @initial_evaluation.id_cc, 
            mental_status_exam: @initial_evaluation.mental_status_exam, 
            recommendation: @initial_evaluation.recommendation }
    assert_redirected_to patient_appointment_path(@patient, @appointment) 
  end

  test "should destroy initial_evaluation" do
    assert_difference('InitialEvaluation.count', -1) do
      delete :destroy, id: @initial_evaluation, patient_id: @patient.id, appointment_id: @appointment.id
    end

    assert_redirected_to patient_path(@patient)
  end
end
