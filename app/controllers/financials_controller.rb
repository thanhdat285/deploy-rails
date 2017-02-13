class FinancialsController < ApplicationController
  before_action :login_required
  before_action :find_financial, only: [:update, :destroy]
  before_action :enough_params, only: [:create, :update]

  def index
    @financials = current_user.financials.order(:day)
  end

  def create
    begin
      day = params["day"]
      day = [day["year"], day["month"], day["date"]].join("/")
      @financial = current_user.financials.new(
        day: day,
        name: params["name"],
        money: params["money"]
      )
      if @financial.save
        render json: {
          id: @financial.id,
          name: @financial.name,
          money: @financial.money,
          day: @financial.day.strftime("%Y/%m/%d")
        }, status: :ok
      else
        render json: {message: @financial.errors}, status: :bad_request
      end
    rescue
      render json: {}, status: :bad_request
    end
  end

  def update
    day = params["day"]
    day = [day["year"], day["month"], day["date"]].join("/")
    update = {
      name: params["name"],
      money: params["money"],
      day: day
    }
    if @financial.update_attributes(update)
      render json: {
        id: @financial.id,
        name: @financial.name,
        money: @financial.money,
        day: @financial.day.strftime("%Y/%m/%d")
      }, status: :ok
    else
      render json: {message: @financial.errors}, status: :bad_request
    end
  end

  def destroy
    if @financial.destroy
      render json: {}, status: :ok
    else
      render json: {message: @financial.errors}, status: :bad_request
    end
  end

  private
  def enough_params
    if ["day", "name", "money"].any? {|k| params[k].nil?}
      return render json: {message: "Not enough params"}, status: :bad_request
    end
    if ["year", "month", "date"].any? {|k| params["day"][k].nil?}
      return render json: {message: "Not enough params"}, status: :bad_request
    end
  end

  def find_financial
    @financial = current_user.financials.find_by(id: params[:id])
    if @financial.nil?
      render json: {}, status: :bad_request
    end
  end
end
