class Api::V1::FavoriteMerchantController < ApplicationController

  def show
    customer = Customer.find(params[:customer_id])
    favorite_id = customer.fav_merchant.id
    render json: MerchantSerializer.new(Merchant.find(favorite_id))
  end

end
