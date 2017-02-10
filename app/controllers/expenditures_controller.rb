class ExpendituresController < ApplicationController
  before_action :login_required

  def index
    @expenditures = current_user.expenditures.order(:day)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  def expenditure_params
    params.require(:expenditure).permit(:name, :money, :day)
  end
end
