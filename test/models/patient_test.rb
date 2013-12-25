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

  test 'it has addresses' do
    p = Patient.new
    assert_empty p.addresses
  
    a = p.addresses.build(street: '123 Main')
    assert_equal a.street, '123 Main'
  end

  test 'it has contacts' do
    p = Patient.new
    assert_empty p.contacts

    c = p.contacts.build(msg_instr: Contact::INSTRUCTIONS[0])
    assert_equal c.msg_instr, Contact::INSTRUCTIONS[0]
  end

  test 'it has progress_notes' do
    p = Patient.new
    assert_empty p.progress_notes

    n = p.progress_notes.build
    assert_not_nil n
  end

  test 'it has a initial_evaluation' do
    p = Patient.new
    assert_empty p.initial_evaluations

    n = p.initial_evaluations.build
    assert_not_nil n
  end

  test 'it has prescriptions' do
    p = Patient.new
    assert_empty p.prescriptions

    n = p.prescriptions.build
    assert_not_nil n
  end
end
