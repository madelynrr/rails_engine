class Api::V1::MerchantsController < ApplicationController

  def index
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: MerchantSerializer.new(invoice.merchant)
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

end
