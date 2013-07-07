require 'test_helper'

class PatientTest < ActiveSupport::TestCase

  test 'it can be instantiated' do
    assert_not_nil Patient.new
  end

  test 'it knows the last appointment' do
    assert_nil Patient.new.last_interaction
    assert_nil Patient.new.last_visit
  end

  test 'it knows the next appointment' do
    assert_empty Patient.new.next_appointment
  end
end
