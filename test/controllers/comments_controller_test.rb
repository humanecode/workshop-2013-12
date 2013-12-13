require "test_helper"

# class Module
#   infect_an_assertion :assert_difference, :must_change
# end

describe CommentsController do
  # def group
  #   @group ||= groups :payroll
  # end
  let(:group) {
    groups :payroll
  }

  # def day
  #   @day ||= Date.today
  # end
  let(:day) { Date.today }

  # def post_model
  #   @post ||= posts :payroll_carl_today
  # end
  let(:post_model) { posts :payroll_carl_today }

  # def setup
  before do
    session[:user_id] = users(:mike).id
  end

  alias must_respond_with assert_response
  alias must_respond_to assert_redirected_to

  # def test_new
  it "gets new action" do
    get :new, group_id: group, day_id: day, post_id: post_model
    # assert_response :success
    must_respond_with :success
  end

  # def test_create
  it "posts create action" do
    assert_difference "Comment.count" do
      post :create, group_id: group, day_id: day, post_id: post_model,
                    comment: { body: "new!" }
    end
    # lambda do
    #   post :create, group_id: group, day_id: day, post_id: post_model,
    #                 comment: { body: "new!" }
    # end.must_change "Comment.count"

    # assert_redirected_to group_day_post_url group, day, post_model
    must_respond_to group_day_post_url(group, day, post_model)
  end
end
