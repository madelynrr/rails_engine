class Api::V1::Merchants::MerchantsController < ApplicationController

  def most_revenue
    merchants = Merchant.top_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

end
