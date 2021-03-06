class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: InvoiceItemSerializer.new(invoice.invoice_items)
    elsif params[:item_id]
      item = Item.find(params[:item_id])
      render json: InvoiceItemSerializer.new(item.invoice_items)
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.all)
    end
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end

end
