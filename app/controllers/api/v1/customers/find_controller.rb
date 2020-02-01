class Api::V1::Customers::FindController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

  def index
    render json: CustomerSerializer.new(Customer.where(id: params[:id]))
  end

end
