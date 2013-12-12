require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def test_can_be_valid
    post = posts :devops_mike_today
    assert post.valid?
  end

  def test_validates_group_id
    post = posts :devops_mike_today
    post.group = nil
    refute post.valid?
    assert_includes post.errors[:group_id], "can't be blank"
  end

  def test_validates_user_id
    post = posts :devops_mike_today
    post.user = nil
    refute post.valid?
    assert_includes post.errors[:user_id], "can't be blank"
  end

  def test_validates_date
    post = posts :devops_mike_today
    post.date = nil
    refute post.valid?
    assert_includes post.errors[:date], "can't be blank"
  end

  def test_validates_uniqueness
    post = posts :devops_mike_today
    post2 = Post.new
    post2.group = post.group
    post2.user = post.user
    post2.date = post.date

    refute post2.valid?
    assert_includes post2.errors[:user_id], "has already been taken"
  end
end
