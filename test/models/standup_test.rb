require 'test_helper'

class StandupTest < ActiveSupport::TestCase
  def standup
    @standup ||= Standup.new
  end

  def group
    @group ||= groups :payroll
  end

  def member
    @member ||= users :ben
  end

  def nonmember
    @nonmember ||= users :zach
  end

  def test_groups
    assert_includes standup.groups, group
  end

  def test_users_for
    assert_includes standup.users_for(group), member
    refute_includes standup.users_for(group), nonmember
  end

  def test_is_member_of?
    assert standup.is_member_of?(group, member)
    refute standup.is_member_of?(group, nonmember)
  end

  def test_add_user_to
    refute standup.is_member_of?(group, nonmember)
    standup.add_user_to group, nonmember
    assert standup.is_member_of?(group, nonmember)
  end

  def test_add_user_to_doesnt_raise
    assert standup.is_member_of?(group, member)
    standup.add_user_to group, member
    assert standup.is_member_of?(group, member)
  end

  def test_remove_user_from
    assert standup.is_member_of?(group, member)
    standup.remove_user_from group, member
    refute standup.is_member_of?(group, member)
  end

  def test_remove_user_from_doesnt_raise
    refute standup.is_member_of?(group, nonmember)
    standup.remove_user_from group, nonmember
    refute standup.is_member_of?(group, nonmember)
  end
end
