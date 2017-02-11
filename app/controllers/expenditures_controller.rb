class ExpendituresController < ApplicationController
  before_action :login_required
  before_action :enough_params, only: :update_all

  def index
    @expenditures = current_user.expenditures.order(:day)
  end

  def create
    day = [params["day_1i"], params["day_2i"], params["day_3i"]].join("/")
    @expenditure = current_user.expenditures.new(
      day: day, name: params["name"], money: params["money"]
    )
    if @expenditure.save
      flash[:success] = "Create new expenditure success"
    else
      flash[:error] = @expenditure.errors
    end
    redirect_to expenditures_path
  end

  private
  def expenditure_params
    params.require(:expenditure).permit(:name, :money, :day)
  end

  def enough_params
    if ["day_1i", "day_2i", "day_3i", "name", "money"].any? {|k| params[k].nil?}
      redirect_to root_path
    end
  end
end
