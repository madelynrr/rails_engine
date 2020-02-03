class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

  def favorite_merchant
    customer = Customer.find(params[:customer_id])
    favorite_id = customer.fav_merchant.id
    render json: MerchantSerializer.new(Merchant.find(favorite_id))
  end
end
