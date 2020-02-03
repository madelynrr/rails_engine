class Api::V1::InvoiceItems::FindInvoiceItemsController < ApplicationController

  def show
    if params[:id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
    elsif params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(item_id: params[:item_id]))
    elsif params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_id: params[:invoice_id]))
    elsif params[:quantity]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(quantity: params[:quantity]))
    elsif params[:unit_price]
      price = (params[:unit_price].to_f * 100).to_i
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: price))
    elsif params[:created_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(updated_at: params[:updated_at]))
    end
  end

end
