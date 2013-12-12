class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find params[:id]
    @day = Date.today
    @prev = @day.prev_day
    @next = @day.next_day
    @posts = @group.posts_for @day
    render "days/show"
  end
end
