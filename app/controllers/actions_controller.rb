class ActionsController < ApplicationController
  before_action :set_task

  class << self
    def template_names_available
      Dir.children('app/views/actions')
        .map { |f| f.sub(/^_/, '').split('.').first }
    end
  end

  VALID_ACTION_NAMES = template_names_available.map(&:freeze).freeze

  def edit
    respond_to do |format|
      if params[:id].in?(VALID_ACTION_NAMES)
        format.html { render params[:id], locals: { task: @task } }
      else
        format.html { redirect_back_or_to root_url, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params.expect(:task_id))
  end
end
