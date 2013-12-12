class HomeController < ApplicationController
  def index
    @standup = Standup.new
  end
end
