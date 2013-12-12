require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  def test_can_be_valid
    mem = memberships :payroll_mike
    assert mem.valid?
  end

  def test_validates_group_id
    mem = memberships :payroll_mike
    mem.group = nil
    refute mem.valid?
    assert_includes mem.errors[:group_id], "can't be blank"
  end

  def test_validates_user_id
    mem = memberships :payroll_mike
    mem.user = nil
    refute mem.valid?
    assert_includes mem.errors[:user_id], "can't be blank"
  end

  def test_validates_uniqueness
    mem = memberships :payroll_mike
    mem2 = Membership.new
    mem2.group = mem.group
    mem2.user = mem.user

    refute mem2.valid?
    assert_includes mem2.errors[:user_id], "has already been taken"
  end
end
