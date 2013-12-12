require "test_helper"

class CommentsControllerTest < ActionController::TestCase
  def group
    @group ||= groups :payroll
  end

  def day
    @day ||= Date.today
  end

  def post_model
    @post ||= posts :payroll_carl_today
  end

  def setup
    session[:user_id] = users(:mike).id
  end

  def test_new
    get :new, group_id: group, day_id: day, post_id: post_model
    assert_response :success
  end

  def test_create
    assert_difference "Comment.count" do
      post :create, group_id: group, day_id: day, post_id: post_model,
                    comment: { body: "new!" }
    end

    assert_redirected_to group_day_post_url group, day, post_model
  end
end
