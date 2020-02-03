class Api::V1::Merchants::MerchantRevenueController < ApplicationController

  def index
    merchants = Merchant.top_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    revenue = Invoice.total_revenue(params[:created_at])
    render json: RevenueSerializer.new(revenue)
  end

end
