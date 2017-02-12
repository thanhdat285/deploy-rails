class ExpendituresController < ApplicationController
  before_action :login_required
  before_action :enough_params, only: :create

  def index
    @expenditures = current_user.expenditures.order(:day)
  end

  def create
    begin
      day = params["day"]
      day = [day["year"], day["month"], day["date"]].join("/")
      @expenditure = current_user.expenditures.new(
        day: day,
        name: params["name"],
        money: params["money"]
      )
      if @expenditure.save
        render json: {
          id: @expenditure.id,
          name: @expenditure.name,
          money: @expenditure.money,
          day: @expenditure.day.strftime("%Y/%m/%d")
        }, status: :ok
      else
        render json: {message: @expenditure.errors}, status: :bad_request
      end
    rescue
      render json: {}, status: :bad_request
    end
  end

  def destroy
    @expenditure = Expenditure.find_by(id: params[:id])
    if @expenditure.destroy
      render json: {}, status: :ok
    else
      render json: {message: @expenditure.errors}, status: :bad_request
    end
  end

  private
  def expenditure_params
    params.require(:expenditure).permit(:name, :money, :day)
  end

  def enough_params
    if ["day", "name", "money"].any? {|k| params[k].nil?}
      return render json: {message: "Not enough params"}, status: :bad_request
    end
    if ["year", "month", "date"].any? {|k| params["day"][k].nil?}
      return render json: {message: "Not enough params"}, status: :bad_request
    end
  end
end
