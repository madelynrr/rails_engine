class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items)
    elsif params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: ItemSerializer.new(invoice.items.uniq)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

end
