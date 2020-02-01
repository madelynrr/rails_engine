class Api::V1::Customers::FindController < ApplicationController

  def show
    if params[:id]
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    elsif params[:first_name]
      render json: CustomerSerializer.new(Customer.find_by(first_name: params[:first_name]))
    elsif params[:last_name]
      render json: CustomerSerializer.new(Customer.find_by(last_name: params[:last_name]))
    end
  end

  def index
    render json: CustomerSerializer.new(Customer.where(id: params[:id]))
  end

end
