require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'it can be instantiated' do
    assert User.new != nil
  end

end
