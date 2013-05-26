require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @patient = patients(:one)
    @appointment = appointments(:one)
  end

  test "should get index" do
    get :index, patient_id: @patient.id
    assert_response :success
    assert_not_nil assigns(:presenter)
  end

  test "should get new" do
    get :new, patient_id: @patient.id
    assert_response :success
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      post :create, patient_id: @patient.id, 
          appointment: { appointment_type: @appointment.appointment_type, 
              end_at_str: @appointment.end_at_str, 
              notes: @appointment.notes, 
              start_at_str: @appointment.start_at_str }
    end

    assert_redirected_to patient_appointment_path(@patient, assigns(:appointment))
  end

  test "should show appointment" do
    get :show, id: @appointment, patient_id: @patient.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appointment, patient_id: @patient.id
    assert_response :success
  end

  test "should update appointment" do
    patch :update, id: @appointment, patient_id: @patient.id, 
        appointment: { appointment_type: @appointment.appointment_type, 
            end_at_str: @appointment.end_at_str, 
            notes: @appointment.notes, 
            start_at_str: @appointment.start_at_str }
    assert_redirected_to patient_appointment_path(@patient, assigns(:appointment))
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment, patient_id: @patient.id
    end

    assert_redirected_to patient_appointments_path(@patient)
  end
end
