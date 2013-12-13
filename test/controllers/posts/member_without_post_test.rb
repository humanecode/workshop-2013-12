require "test_helper"

class MemberWithoutPostTest < ActionController::TestCase
  tests PostsController

  def group
    @group ||= groups :payroll
  end

  def day
    @day ||= Date.today
  end

  def setup
    session[:user_id] = users(:mike).id
  end

  def test_index
    get :index, group_id: group, day_id: day
    assert_response :success
  end

  def test_show
    get :show, group_id: group, day_id: day, id: posts(:payroll_carl_today)
    assert_response :success
  end

  def test_new
    get :new, group_id: group, day_id: day
    assert_response :success
  end

  def test_create
    assert_difference "Post.count" do
      post :create, group_id: group, day_id: day, post: { body: "O HAI" }
    end
    assert_redirected_to group_day_post_path(group, day, assigns(:post))
  end
end
