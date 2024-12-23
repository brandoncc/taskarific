class TimelinesController < ApplicationController
  def show
    @timeline = Timeline.new
  end
end
