class Api::V1::MerchantsController < ApplicationController

  def index
      render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: MerchantSerializer.new(invoice.merchant)
    else
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    end
  end

end
