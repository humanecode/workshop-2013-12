require "test_helper"

class PermissionsHelperTest < ActionView::TestCase
  # Anonymous - false
  # Member w post - false
  # Member wo post - true

  def current_user
    @current_user
  end

  def setup
    @group = groups :payroll
    @day = Date.today
  end

  def test_can_create_post_anon
    @current_user = nil
    retval = can_create_post?
    assert_equal false, retval
  end

  def test_can_create_post_member_w_post
    @current_user = Standup.new.posts_for(@group, @day).first.user
    retval = can_create_post?
    assert_equal false, retval
  end

  def test_can_create_post_member_wo_post
    @current_user = users :mike
    retval = can_create_post?
    assert_equal true, retval
  end

  def test_can_create_post_nonmember
    @current_user = users :zach
    retval = can_create_post?
    assert_equal false, retval
  end


end
