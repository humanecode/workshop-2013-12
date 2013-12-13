require "test_helper"
require "controllers/posts/member_without_post_test"

class AnonymousTest < MemberWithoutPostTest
  tests PostsController

  def setup
    session[:user_id] = nil
  end

  def test_new
    get :new, group_id: group, day_id: day
    assert_redirected_to group_day_posts_path(group, day)
    # assert_redirected_to login_path
  end

  def test_create

  end
end
