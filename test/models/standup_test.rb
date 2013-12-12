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

  def test_posts_for
    assert_equal 3, standup.posts_for(group, Date.today).count
    assert_equal 3, standup.posts_for(group, Date.yesterday).count
    assert_equal 0, standup.posts_for(group, Date.tomorrow).count
  end

  def test_posts_for_today
    assert_includes standup.posts_for(group, Date.today), posts(:payroll_ben_today)
  end

  def test_posts_for_yesterday
    assert_includes standup.posts_for(group, Date.yesterday), posts(:payroll_ben_yesterday)
  end

  def test_post_for
    assert_equal posts(:payroll_carl_today),
                 standup.post_for(group, users(:carl), Date.today)
    assert_equal posts(:payroll_heidi_yesterday),
                 standup.post_for(group, users(:heidi), Date.yesterday)
    assert_equal posts(:payroll_jack_today),
                 standup.post_for(group, users(:jack), Date.today)
    assert_nil standup.post_for(group, users(:mike), Date.today)
  end

  def test_add_post
    # mike doesn't have any posts for payroll
    mike = users :mike
    assert_difference "Post.count", 1 do
      standup.add_post group, mike, Date.today, "I'm late, but I got it done."
    end
  end

  def test_add_post_wont_create_duplicates
    # ben already has a post for payroll
    ben = users :ben
    assert_difference "Post.count", 0 do
      post = standup.add_post group, ben, Date.today, "This is a duplicate."
      refute post.valid?
    end
  end
end
