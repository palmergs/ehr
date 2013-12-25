require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'it can be instantiated' do
    assert User.new != nil
  end

  test 'hash is dates mapped to empty arrays if no appointents' do
    u = User.new
    hash = u.appointments_by_date
    assert_not_nil hash
    assert_kind_of Hash, hash
    assert hash.count, 10
  end
end
