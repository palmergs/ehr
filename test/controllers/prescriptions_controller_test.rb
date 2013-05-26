require 'test_helper'

class PrescriptionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @prescription = prescriptions(:one)
    @patient = patients(:one)
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

  test "should create prescription" do
    assert_difference('Prescription.count') do
      post :create, 
          patient_id: @patient.id,
          prescription: { medication_status: @prescription.medication_status, 
              notes: @prescription.notes, 
              prescription: @prescription.prescription }
    end

    assert_redirected_to patient_path(@patient)
  end

  test "should show prescription" do
    get :show, id: @prescription, patient_id: @patient.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prescription, patient_id: @patient.id
    assert_response :success
  end

  test "should update prescription" do
    patch :update, id: @prescription, patient_id: @patient.id,
        prescription: { medication_status: @prescription.medication_status, 
            notes: @prescription.notes, 
            prescription: @prescription.prescription }
    assert_redirected_to patient_path(@patient)
  end

  test "should destroy prescription" do
    assert_difference('Prescription.count', -1) do
      delete :destroy, id: @prescription, patient_id: @patient.id
    end

    assert_redirected_to patient_path(@patient)
  end
end
