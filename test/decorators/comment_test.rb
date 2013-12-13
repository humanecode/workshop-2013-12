require 'test_helper'

# class CommentTest < ActiveSupport::TestCase
describe Comment do
  # def test_can_be_valid
  it "can be valid" do
    comment = comments :payroll_carl_today_one
    # assert comment.valid?
    comment.must_be :valid?
  end

  # def test_validates_post_id
  it "will validate post_id" do
    comment = comments :payroll_carl_today_one
    comment.post = nil
    # refute comment.valid?
    comment.wont_be :valid?
    # assert_includes comment.errors[:post_id], "can't be blank"
    comment.errors[:post_id].must_include "can't be blank"
  end

  # def test_validates_user_id
  it "will validate user_id" do
    comment = comments :payroll_carl_today_one
    comment.user = nil
    # refute comment.valid?
    comment.wont_be :valid?
    # assert_includes comment.errors[:user_id], "can't be blank"
    comment.errors[:user_id].must_include "can't be blank"
  end
end
