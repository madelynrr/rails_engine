class Api::V1::MerchantsController < ApplicationController

  def index
      render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: MerchantSerializer.new(invoice.merchant)
    elsif params[:item_id]
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(item.merchant)
    else
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    end
  end

end
