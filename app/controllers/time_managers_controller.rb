class TimeManagersController < ApplicationController
  before_action :login_required
  before_action :check_params, only: :create

  def index
    @time_managers = TimeManager.all.order(:from)
  end

  def create
    @time_manager = current_user.time_managers.new(
      name: params["name"],
      from: params["from"],
      to: params["to"]
    )
    if @time_manager.save
      render json: {
        name: @time_manager.name,
        from: @time_manager.from.strftime("%H:%m %d/%m/%Y"),
        to: @time_manager.to.strftime("%H:%m %d/%m/%Y"),
        status: @time_manager.status
      }, status: :ok
    else
      render json: {error: @time_manager.errors}, status: :bad_request
    end
  end

  private
  def check_params
    if %w(name from to).any? {|key| params[key].nil?}
      render json: {error: 'Invalid params'}, status: :bad_request
    end
  end
end
