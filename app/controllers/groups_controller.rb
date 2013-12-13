class GroupsController < ApplicationController
  def index
    @groups = Standup.new.groups
  end

  def show
    @group = Standup.new.groups.find params[:id]
    @day = Date.today
    @prev = @day.prev_day
    @next = @day.next_day
    @posts = @group.posts_for @day
    render "posts/index"
  end
end
