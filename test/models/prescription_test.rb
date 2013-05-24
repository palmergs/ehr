require 'test_helper'

class PrescriptionTest < ActiveSupport::TestCase

  test 'it can be instantiated' do
    assert Prescription.new != nil
  end
end
