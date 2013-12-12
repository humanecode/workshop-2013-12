require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_can_be_valid
    comment = comments :payroll_carl_today_one
    assert comment.valid?
  end

  def test_validates_post_id
    comment = comments :payroll_carl_today_one
    comment.post = nil
    refute comment.valid?
    assert_includes comment.errors[:post_id], "can't be blank"
  end

  def test_validates_user_id
    comment = comments :payroll_carl_today_one
    comment.user = nil
    refute comment.valid?
    assert_includes comment.errors[:user_id], "can't be blank"
  end
end
