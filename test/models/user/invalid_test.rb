require "test_helper"

class User::InvalidTest < ActiveSupport::TestCase
  def test_password_error
    user = User::Invalid.new "test@example.com"
    refute user.valid?
    assert user.errors[:password].present?
    assert_includes user.errors[:password], "is not correct"
  end

  def test_email_present
    user = User::Invalid.new "test@example.com"
    refute user.valid?
    assert user.errors[:email].blank?
  end

  def test_email_blank
    user = User::Invalid.new ""
    refute user.valid?
    assert user.errors[:email].present?
    assert_includes user.errors[:email], "must be entered"
  end
end
