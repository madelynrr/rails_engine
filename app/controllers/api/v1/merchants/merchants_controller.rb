class Api::V1::Merchants::MerchantsController < ApplicationController

  def index
    merchants = Merchant.top_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

end
