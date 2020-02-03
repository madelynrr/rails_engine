class Api::V1::FavoriteCustomerController < ApplicationController

  def show
    merchant = Merchant.find(params[:merchant_id])
    customer = merchant.fav_customer
    render json: CustomerSerializer.new(Customer.find(customer.id))
  end

end
