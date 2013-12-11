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

  def test_create_1_record
    assert_difference "User.count", 1 do
      create_random_user
    end
  end

  def test_create_3_records
    assert_difference "User.count", 3 do
      3.times { create_random_user }
    end
  end

  def test_create_10_records
    assert_difference "User.count", 10 do
      10.times { create_random_user }
    end
  end

  def create_random_user
    random = SecureRandom.hex(8)
    User.create! email: "#{random}@example.com",
                 password: random,
                 password_confirmation: random
  end

  def assert_valid user
    assert_predicate user, :valid?
  end

  def refute_valid user
    refute_predicate user, :valid?
  end
end
