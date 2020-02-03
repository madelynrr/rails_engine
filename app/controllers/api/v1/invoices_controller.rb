class Api::V1::InvoicesController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      render json: InvoiceSerializer.new(customer.invoices)
    elsif params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: InvoiceSerializer.new(merchant.invoices)
    elsif params[:invoice_item_id]
      invoice_item = InvoiceItem.find(params[:invoice_item_id])
      render json: InvoiceSerializer.new(invoice_item.invoice)
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end

end
