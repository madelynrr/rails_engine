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
    if params[:invoice_item_id]
      invoice_item = InvoiceItem.find(params[:invoice_item_id])
      render json: ItemSerializer.new(invoice_item.item)
    else
      render json: ItemSerializer.new(Item.find(params[:id]))
    end
  end

end
