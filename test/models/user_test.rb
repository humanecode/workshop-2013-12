require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_can_authenticate
    mike = users :mike
    assert mike.authenticate("mike")
  end
end
