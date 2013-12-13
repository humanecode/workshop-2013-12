class PostsController < ApplicationController
  include PermissionsHelper
  before_action :set_group_and_day_and_posts
  before_action :set_post, only: [:show]
  # before_filter :enforce_login, only: [:new, :create]

  # GET /groups/:group_id/days/:day_id/posts
  def index
    @prev = @day.prev_day
    @next = @day.next_day
  end

  # GET /groups/:group_id/days/:day_id/posts/1
  def show
  end

  # GET /groups/:group_id/days/:day_id/posts/new
  def new
    return redirect_to group_day_posts_path(@group, @day) unless can_create_post?

    @post = @posts.new
  end

  # POST /groups/:group_id/days/:day_id/posts
  def create
    @post = Standup.new.add_post @group, current_user, @day, post_params[:body]

    if @post.valid?
      redirect_to group_day_post_url(@group, @day, @post), notice: "Post was successfully created."
    else
      render action: "new"
    end
  end

  private

  def already_has_post?
    Standup.new.post_for(@group, current_user, @day).present?
  end

  def set_group_and_day_and_posts
    standup = Standup.new
    @group = standup.groups.find params[:group_id]
    @day = date
    @posts = standup.posts_for @group, @day
  end

  def date
    case params[:id]
    when "today"
      Date.today
    when "yesterday"
      Date.yesterday
    when "tomorrow"
      Date.tomorrow
    else
      Date.parse params[:day_id]
    end
  rescue ArgumentError
    raise ActiveRecord::RecordNotFound
  end

  def set_post
    @post = @posts.find params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params[:post]
  end
end
