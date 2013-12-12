class CommentsController < ApplicationController
  before_action :set_group_and_day_and_post_and_comments

  # GET /comments/new
  def new
    @comment = @comments.new
  end

  # POST /comments
  def create
    @comment = Standup.new.add_comment @post, current_user, comment_params[:body]

    if @comment.valid?
      redirect_to group_day_post_url(@group, @day, @post), notice: "Comment was successfully created."
    else
      render action: "new"
    end
  end

  private

  def set_group_and_day_and_post_and_comments
    standup = Standup.new
    @group = standup.groups.find params[:group_id]
    @day = date
    @post = @group.posts_for(@day).find params[:post_id]
    @comments = @post.comments
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params[:comment]
  end
end
