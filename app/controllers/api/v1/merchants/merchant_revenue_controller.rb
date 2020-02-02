class Api::V1::Merchants::MerchantRevenueController < ApplicationController

  def index
    merchants = Merchant.top_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    
  end

end
