class Api::V1::TransactionsController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      render json: TransactionSerializer.new(customer.transactions)
    elsif params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      render json: TransactionSerializer.new(invoice.transactions)
    else
      render json: TransactionSerializer.new(Transaction.all)
    end
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end

end
