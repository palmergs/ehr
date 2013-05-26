require 'test_helper'

class AllergiesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in :user, @user 
    @patient = patients(:one)
    @allergy = allergies(:one)
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

  test "should create allergy" do
    assert_difference('Allergy.count') do
      post :create, patient_id: @patient.id, 
          allergy: { medication_or_food: @allergy.medication_or_food, reaction: @allergy.reaction }
    end

    assert_redirected_to patient_path(@patient)
  end

  test "should show allergy" do
    get :show, patient_id: @patient.id, id: @allergy.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allergy, patient_id: @patient.id
    assert_response :success
  end

  test "should update allergy" do
    patch :update, id: @allergy, patient_id: @patient.id, 
        allergy: { medication_or_food: @allergy.medication_or_food, reaction: @allergy.reaction }
    assert_redirected_to patient_path(@patient)
  end

  test "should destroy allergy" do
    assert_difference('Allergy.count', -1) do
      delete :destroy, id: @allergy, patient_id: @patient.id
    end

    assert_redirected_to patient_path(@patient)
  end
end
