require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_can_authenticate
    mike = users :mike
    refute_nil mike.authenticate("mike")
  end

  def test_authenticate
    mike = users :mike
    user = User.authenticate mike.email, "mike"
    refute_nil user
    assert_valid user
  end

  def test_authenticate_bad_password
    mike = users :mike
    user = User.authenticate mike.email, "mike".reverse
    refute_nil user
    refute_valid user
  end

  def test_authenticate_bad_email
    mike = users :mike
    user = User.authenticate "dontexist@example.com", "nope"
    refute_nil user
    refute_valid user
  end

  def assert_valid user
    assert_predicate user, :valid?
  end

  def refute_valid user
    refute_predicate user, :valid?
  end
end
