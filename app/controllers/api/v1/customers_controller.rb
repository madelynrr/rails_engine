class Api::V1::CustomersController < ApplicationController
  def index
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: CustomerSerializer.new(invoice.customer)
    else
      render json: CustomerSerializer.new(Customer.all)
    end
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

end
