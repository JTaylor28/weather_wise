class Api::V0::SalariesController < ApplicationController
  def index
    salaries = SalaryFacade.new(params[:location]).find_salaries
    render json: SalarySerializer.new(salaries)
  end
end