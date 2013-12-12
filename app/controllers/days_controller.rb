class DaysController < ApplicationController
  before_filter :set_group
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to group_path(@group)
  end

  def index
    @day = Date.today
    @prev = @day.prev_day
    @next = @day.next_day
    @posts = @group.posts_for @day
    render "show"
  end

  def show
    @day = date
    @prev = @day.prev_day
    @next = @day.next_day
    @posts = @group.posts_for @day
  end

  protected

  def set_group
    @group = Group.find params[:group_id]
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
      Date.parse params[:id]
    end
  rescue ArgumentError
    raise ActiveRecord::RecordNotFound
  end
end
