class Api::V1::Customers::RandomController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.all.sample(1))
  end

end
